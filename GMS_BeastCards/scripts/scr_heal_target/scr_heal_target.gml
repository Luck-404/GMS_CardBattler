//===============================================================================//
//
// SCRIPT: SCR_HEAL_TARGET
// FUNCTION: Resolves a healing attempt on a target battle Beast.
//           Healing still resolves when the target is at Maximum HP.
//           Actual HP restored is capped at Maximum HP.
//           Checks healing-triggered Traps before restoring HP.
//           Converts excess healing into Overhealth during Bloomtide.
//           Triggers healing-based effects using actual HP restored.
//
//===============================================================================//

function scr_heal_target(_val_amount,_ref_target,_flag_trigger_auras=true){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	if (_ref_target._val_cur_hp <= 0){
		return false;
	}

	//----------------//
	//CHECK BLOOMTIDE//
	//----------------//
	var _ref_bloomtide =
		scr_check_for_status(
			"EVENT: BLOOMTIDE",
			global.list_statuses
		);

	var _flag_bloomtide =
		(_ref_bloomtide != -1);

	//-------------------//
	//CHECK HEALING TRAPS//
	//-------------------//
	/*
		A valid healing attempt reaches this check even when
		the target is already at Maximum HP.
	*/
	if (scr_trigger_heal_traps(_ref_target)){
		return false;
	}

	//---------------------//
	//CALCULATE HP RESTORED//
	//---------------------//
	var _val_missing_hp =
		max(
			0,
			_ref_target._val_max_hp -
			_ref_target._val_cur_hp
		);

	var _val_healed =
		min(
			_val_amount,
			_val_missing_hp
		);

	//------------------//
	//CALCULATE OVERHEAL//
	//------------------//
	var _val_overheal =
		0;

	if (_flag_bloomtide){

		_val_overheal =
			max(
				0,
				_val_amount -
				_val_healed
			);
	}

	//--------//
	//HEAL HP//
	//--------//
	_ref_target._val_cur_hp +=
		_val_healed;

	_ref_target._val_cur_hp =
		min(
			_ref_target._val_cur_hp,
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
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_val_healed),
		undefined,
		c_green,
		_ref_target.x + irandom_range(-32,32),
		_ref_target.y - 24 + irandom_range(-32,32)
	);

	//----------------//
	//GRANT OVERHEALTH//
	//----------------//
	if (_val_overheal > 0){

		_ref_target._val_overhealth +=
			_val_overheal;

		scr_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_val_overheal) + " OVERHEALTH",
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 48 + irandom_range(-16,16)
		);
	}

	//--------------------------//
	//TRIGGER GLOBAL HEAL BUFFS//
	//--------------------------//
	/*
		These still use ACTUAL HP restored.

		A +0 heal resolves visually and can trigger healing
		Traps, but does not falsely activate effects based on
		HP actually being restored.
	*/
	if (_val_healed > 0){

		scr_trigger_heart_of_forest(
			_ref_target,
			_val_healed
		);
	}

	//----------------------//
	//TRIGGER HEALING AURAS//
	//----------------------//
	if (_flag_trigger_auras){

		scr_trigger_heal_auras(
			_ref_target,
			_val_amount
		);
	}

	//---------------------//
	//TRIGGER HEALING BUFFS//
	//---------------------//
	scr_trigger_heal_buffs(
		_ref_target,
		_val_amount
	);

	//------------------------//
	//HEAL ATTEMPT RESOLVED//
	//------------------------//
	return true;
}