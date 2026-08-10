//===============================================================================//
//
// SCRIPT: SCR_HEAL_TARGET
// FUNCTION: Restores HP to a target battle Beast.
//           Checks healing-triggered Traps before restoring HP.
//           Healing cannot exceed Maximum HP.
//           Triggers healing-based Auras using actual HP restored.
//           Aura-generated healing may disable recursive Aura triggering.
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
	//CHECK MISSING HP//
	//----------------//
	if (_ref_target._val_cur_hp >= _ref_target._val_max_hp){
		return false;
	}

	//-------------------//
	//CHECK HEALING TRAPS//
	//-------------------//
	if (scr_trigger_heal_traps(_ref_target)){
		return false;
	}

	//--------------//
	//APPLY HEALING//
	//--------------//
	var _val_hp_before =
		_ref_target._val_cur_hp;

	_ref_target._val_cur_hp =
		min(
			_ref_target._val_max_hp,
			_ref_target._val_cur_hp +
				_val_amount
		);

	var _val_healed =
		_ref_target._val_cur_hp -
		_val_hp_before;

	//-------------//
	//SPAWN POPUP//
	//-------------//
	if (_val_healed > 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"+" + string(_val_healed),
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
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

	return (_val_healed > 0);
}