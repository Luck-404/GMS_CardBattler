//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_SECOND_WIND_DIRECT_BONUS
// FUNCTION: Returns Second Wind's direct-damage bonus percentage while
//           the host's next Attack is actively resolving.
//
//===============================================================================//

function scr_status_get_second_wind_direct_bonus(_ref_caster,_stct_card){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return 0;
	}

	//================//
	//VALIDATE CARD//
	//================//
	if (!is_struct(_stct_card)){
		return 0;
	}

	if (_stct_card._str_card_type != "ATTACK"){
		return 0;
	}

	//================//
	//CHECK EFFECT CONTEXT//
	//================//
	if (!global.flag_card_effect_resolving){
		return 0;
	}

	if (global.ref_caster_beast != _ref_caster){
		return 0;
	}

	//================//
	//CHECK SECOND WIND//
	//================//
	var _ref_second_wind = scr_status_check(
		"SECOND_WIND",
		_ref_caster
	);

	if (
		_ref_second_wind == -1 ||
		!instance_exists(_ref_second_wind)
	){
		return 0;
	}

	//================//
	//CHECK ACTIVATION//
	//================//
	if (!_ref_second_wind._flag_second_wind_active){
		return 0;
	}


	//================//
	//RETURN TOTAL BONUS//
	//================//
	// Stored magnitude is the bonus per stack.
	// All stacks contribute to the next Attack.

	return max(
		0,
		_ref_second_wind._val_status_magnitude *
		_ref_second_wind._ct_status_stacks
	);
}