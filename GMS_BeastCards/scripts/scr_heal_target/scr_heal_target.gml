//===============================================================================//
//
// SCRIPT: SCR_HEAL_TARGET
// FUNCTION: Restores HP to a target battle Beast.
//           Checks healing-triggered Traps before restoring HP.
//           Converts excess healing into Overhealth during Bloomtide.
//           Triggers healing-based Auras using actual HP restored.
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

	//----------------//
	//CHECK BLOOMTIDE//
	//----------------//
	var _ref_bloomtide = scr_check_for_status(
		"EVENT: BLOOMTIDE",
		global.list_statuses
	);

	var _flag_bloomtide =
		(_ref_bloomtide != -1);

	//----------------//
	//CHECK MISSING HP//
	//----------------//
	if (
		_ref_target._val_cur_hp >=
		_ref_target._val_max_hp &&
		!_flag_bloomtide
	){
		return false;
	}

	//-------------------//
	//CHECK HEALING TRAPS//
	//-------------------//
	if (scr_trigger_heal_traps(_ref_target)){
		return false;
	}

	//---------------------//
	//CALCULATE HP RESTORED//
	//---------------------//
	var _val_missing_hp = max(
		0,
		_ref_target._val_max_hp -
		_ref_target._val_cur_hp
	);

	var _val_healed = min(
		_val_amount,
		_val_missing_hp
	);

	//------------------//
	//CALCULATE OVERHEAL//
	//------------------//
	var _val_overheal =
		0;

	if (_flag_bloomtide){

		_val_overheal = max(
			0,
			_val_amount -
			_val_healed
		);
	}

	//--------//
	//HEAL HP//
	//--------//
	if (_val_healed > 0){

		_ref_target._val_cur_hp +=
			_val_healed;

		scr_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_val_healed),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

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

	//------------------------//
	//TRIGGER GLOBAL HEAL BUFFS//
	//------------------------//
	if (_val_healed > 0){

		scr_trigger_heart_of_forest(
			_ref_target,
			_val_healed
		);
	}

	//----------------------//
	//TRIGGER HEALING AURAS//
	//----------------------//
	if (
		_val_healed > 0 &&
		_flag_trigger_auras
	){

		scr_trigger_heal_auras(
			_ref_target,
			_val_healed
		);
	}
	
	//---------------------//
	//TRIGGER HEALING BUFFS//
	//---------------------//
	if (_val_healed > 0){

		scr_trigger_heal_buffs(
			_ref_target,
			_val_healed
		);
	}	

	return (
		_val_healed > 0 ||
		_val_overheal > 0
	);
}