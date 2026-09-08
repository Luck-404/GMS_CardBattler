//===============================================================================//
//
// SCRIPT: SCR_STATUS_TICK_LIFETIME
// FUNCTION: Advances a status lifetime by one turn.
//           Infinite statuses never lose lifetime.
//           Queues timed statuses for destruction when lifetime reaches zero.
//
//===============================================================================//
function scr_status_tick_lifetime(_ref_status){

	if (!instance_exists(_ref_status)){
		return false;
	}

	//----------------//
	//INFINITE STATUS//
	//----------------//
	if (_ref_status._flag_status_infinite){

		_ref_status._str_status_command =
			"WAIT";

		return false;
	}

	//-------------------//
	//DOT DURATION HOLD//
	//-------------------//
	if (
		_ref_status._str_status_type == "DOT" &&
		instance_exists(_ref_status._ref_host)
	){

		var _val_hold_chance =
			scr_status_get_dot_lifetime_hold_chance(
				_ref_status._ref_host
			);

		if (
			_val_hold_chance > 0 &&
			irandom_range(1,100) <= _val_hold_chance
		){

			_ref_status._str_status_command =
				"WAIT";

			return false;
		}
	}

	//----------------//
	//REDUCE LIFETIME//
	//----------------//
	_ref_status._val_status_lifetime--;

	if (_ref_status._val_status_lifetime <= 0){

		_ref_status._val_status_lifetime =
			0;

		_ref_status._str_status_command =
			"DEATH";

		return true;
	}

	_ref_status._str_status_command =
		"WAIT";

	return false;
}