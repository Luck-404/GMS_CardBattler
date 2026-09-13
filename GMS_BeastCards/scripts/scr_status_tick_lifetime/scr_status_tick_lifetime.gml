//===============================================================================//
//
// SCRIPT: SCR_STATUS_TICK_LIFETIME
// FUNCTION: Advances a Status lifetime by one turn.
//           Infinite Statuses never lose lifetime.
//           DoTs may preserve their duration through lifetime-hold effects.
//           Queues timed Statuses for DEATH when lifetime reaches zero.
//
// ARGUMENTS: _ref_status is the Status whose lifetime is advanced.
// RETURNS: True when the Status reaches zero lifetime and queues DEATH;
//          otherwise false.
//
//===============================================================================//

function scr_status_tick_lifetime(_ref_status){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return false;
	}

	//=================//
	//INFINITE STATUS//
	//=================//
	if (_ref_status._flag_status_infinite){

		_ref_status._str_status_command = "WAIT";

		return false;
	}

	//-------------------//
	//VALIDATE LIFETIME//
	//-------------------//
	if (!is_real(_ref_status._val_status_lifetime)){

		_ref_status._str_status_command = "DEATH";

		return true;
	}

	//===================//
	//DOT DURATION HOLD//
	//===================//
	if (
		_ref_status._str_status_type == "DOT" &&
		instance_exists(_ref_status._ref_host)
	){

		var _val_hold_chance = scr_status_get_dot_lifetime_hold_chance(
			_ref_status._ref_host
		);

		if (
			_val_hold_chance > 0 &&
			irandom_range(1,100) <= _val_hold_chance
		){

			_ref_status._str_status_command = "WAIT";

			return false;
		}
	}

	//=================//
	//REDUCE LIFETIME//
	//=================//
	_ref_status._val_status_lifetime--;

	if (_ref_status._val_status_lifetime <= 0){

		_ref_status._val_status_lifetime = 0;
		_ref_status._str_status_command = "DEATH";

		return true;
	}

	_ref_status._str_status_command = "WAIT";

	return false;
}