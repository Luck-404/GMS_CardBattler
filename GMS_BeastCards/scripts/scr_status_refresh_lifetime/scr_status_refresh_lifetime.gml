//===============================================================================//
//
// SCRIPT: SCR_STATUS_REFRESH_LIFETIME
// FUNCTION: Updates an existing status after reapplication.
//           Stackable timed statuses remember their highest applied lifetime.
//           Unstackable timed statuses extend without being shortened.
//           Infinite statuses do not use turn lifetime.
//
//===============================================================================//
function scr_status_refresh_lifetime(_ref_status,_val_lifetime){

	if (!instance_exists(_ref_status)){
		return false;
	}

	//----------------//
	//INFINITE STATUS//
	//----------------//
	if (_ref_status._flag_status_infinite){
		return true;
	}

	_val_lifetime =
		max(1,_val_lifetime);

	//-----------------//
	//STACKABLE TIMED//
	//-----------------//
	if (_ref_status._flag_status_stackable){

		if (
			_val_lifetime >
			_ref_status._val_status_lifetime_max
		){
			_ref_status._val_status_lifetime_max =
				_val_lifetime;
		}

		_ref_status._val_status_lifetime =
			_ref_status._val_status_lifetime_max;

		return true;
	}

	//-------------------//
	//UNSTACKABLE TIMED//
	//-------------------//
	_ref_status._val_status_lifetime =
		max(
			_ref_status._val_status_lifetime,
			_val_lifetime
		);

	_ref_status._val_status_lifetime_max =
		max(
			_ref_status._val_status_lifetime_max,
			_val_lifetime
		);

	return true;
}