//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HEAL_TARGET
// FUNCTION: Resolves a healing attempt on a target battle Beast.
//           Healing still resolves at Maximum HP, while actual HP restoration
//           is capped at Maximum HP. Resolves healing modifiers, Antiheal,
//           healing Traps, Bloomtide Overhealth, VFX/SFX, and heal triggers.
//
// INPUTS:   _val_amount - Base healing amount before received-healing modifiers.
//           _ref_target - Living battle Beast receiving the healing effect.
//           _flag_trigger_auras - Whether healing Aura triggers should resolve.
// USES:     Healing-received modifiers, Antiheal, Bloomtide, healing Traps,
//           Status triggers, shared Heal presentation, and GUI feedback.
//
//===============================================================================//

function scr_battle_heal_target(_val_amount,_ref_target,_flag_trigger_auras=true){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_ref_target._val_cur_hp <= 0){
		return false;
	}

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
	if (_val_amount <= 0){
		return false;
	}

	#endregion

	#region PRE-HEAL EFFECTS

	//----------------//
	//CHECK BLOOMTIDE//
	//----------------//
	var _ref_bloomtide = scr_status_check("EVENT: BLOOMTIDE",global.list_statuses);
	var _flag_bloomtide = (_ref_bloomtide != -1);

	//---------------------------//
	//CHECK BEFORE HEALING TRAPS//
	//---------------------------//
	/*
		A valid healing attempt reaches this check even when
		the target is already at Maximum HP.

		BEFORE Traps may cancel the healing entirely.
	*/
	if (scr_battle_trigger_heal_traps(_ref_target,"BEFORE")){
		return false;
	}

	//------------------------//
	//MODIFY HEALING RECEIVED//
	//------------------------//
	var _val_healing = scr_battle_get_healing_received_amount(_val_amount,_ref_target);

	//----------------//
	//CHECK ANTIHEAL//
	//----------------//
	var _ref_antiheal = scr_status_check("ANTIHEAL",_ref_target);

	if (_ref_antiheal != -1){
		_val_healing = floor(_val_healing * 0.50);
	}

	#endregion

	#region HEALING

	//---------------------//
	//CALCULATE HP RESTORED//
	//---------------------//
	var _val_missing_hp = max(0,_ref_target._val_max_hp - _ref_target._val_cur_hp);
	var _val_healed = min(_val_healing,_val_missing_hp);

	//------------------//
	//CALCULATE OVERHEAL//
	//------------------//
	var _val_overheal = 0;

	if (_flag_bloomtide){
		_val_overheal = max(0,_val_healing - _val_healed);
	}

	//--------//
	//HEAL HP//
	//--------//
	_ref_target._val_cur_hp = min(
		_ref_target._val_cur_hp + _val_healed,
		_ref_target._val_max_hp
	);

	//-------------//
	//HEAL POPUP//
	//-------------//
	/*
		Always display the healing result.

		A full-HP target displays +0 so the player can still
		see that the healing effect successfully resolved.
	*/
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_healed),
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//------------------//
	//HEAL PRESENTATION//
	//------------------//
	scr_battle_play_heal_vfx(_ref_target);

	#endregion

	#region OVERHEALTH

	//----------------//
	//GRANT OVERHEALTH//
	//----------------//
	if (_val_overheal > 0){

		_ref_target._val_overhealth += _val_overheal;

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_val_overheal) + " OVERHEALTH",
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 48 + irandom_range(-16,16)
		);
	}

	#endregion

	#region HEAL TRIGGERS

	//--------------------------//
	//HEART OF THE FOREST//
	//--------------------------//
	/*
		Heart of the Forest uses actual HP restored rather than
		the attempted healing amount.
	*/
	if (_val_healed > 0){
		scr_status_trigger_heart_of_the_forest(_ref_target,_val_healed);
	}

	//----------------------//
	//TRIGGER HEALING AURAS//
	//----------------------//
	if (_flag_trigger_auras){
		scr_status_trigger_heal_auras(_ref_target,_val_healing);
	}

	//---------------------//
	//TRIGGER HEALING BUFFS//
	//---------------------//
	scr_status_trigger_heal_buffs(_ref_target,_val_healing);

	#endregion

	#region POST-HEAL TRAPS

	//--------------------------//
	//CHECK AFTER HEALING TRAPS//
	//--------------------------//
	/*
		Pulled Under resolves after healing completes so the
		healed Beast may then be Banished.
	*/
	scr_battle_trigger_heal_traps(_ref_target,"AFTER");

	#endregion

	return true;
}