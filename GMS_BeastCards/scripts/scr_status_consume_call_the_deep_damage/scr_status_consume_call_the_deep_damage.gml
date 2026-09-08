//===============================================================================//
//
// SCRIPT: scr_status_consume_call_the_deep_damage
// FUNCTION: Consumes Call the Deep from the supplied Beast.
//           Returns the stored additional direct damage amount.
//
//===============================================================================//

function scr_status_consume_call_the_deep_damage(_ref_caster){

	if (!instance_exists(_ref_caster)){
		return 0;
	}

	//----------------//
	//CHECK BUFF//
	//----------------//
	var _ref_status =
		scr_status_check(
			"CALL_THE_DEEP",
			_ref_caster
		);

	if (_ref_status == -1){
		return 0;
	}

	if (!instance_exists(_ref_status)){
		return 0;
	}

	//----------------//
	//GET BONUS//
	//----------------//
	var _val_bonus =
		max(
			0,
			_ref_status._val_status_magnitude
		);

	//----------------//
	//CONSUME BUFF//
	//----------------//
	scr_status_buff_call_the_deep(
		"DEATH",
		_ref_status
	);

	return _val_bonus;
}