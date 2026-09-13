//===============================================================================//
//
// SCRIPT: SCR_STATUS_REFRESH_LIFETIME
// FUNCTION: Updates an existing Status after reapplication.
//           Stackable timed Statuses remember their highest applied lifetime.
//           Unstackable timed Statuses extend without being shortened.
//           Infinite Statuses do not use turn lifetime.
//
// ARGUMENTS: _ref_status is the existing Status being refreshed and
//            _val_lifetime is the newly applied duration.
// RETURNS: True when the refresh succeeds; otherwise false.
//
//===============================================================================//

function scr_status_refresh_lifetime(_ref_status,_val_lifetime){

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
		return true;
	}

	//-------------------//
	//VALIDATE LIFETIME//
	//-------------------//
	if (_val_lifetime == undefined){
		return false;
	}

	if (!is_real(_val_lifetime)){
		return false;
	}

	_val_lifetime = max(1,_val_lifetime);

	//=================//
	//STACKABLE TIMED//
	//=================//
	if (_ref_status._flag_status_stackable){

		_ref_status._val_status_lifetime_max = max(
			_ref_status._val_status_lifetime_max,
			_val_lifetime
		);

		_ref_status._val_status_lifetime = _ref_status._val_status_lifetime_max;

		return true;
	}

	//===================//
	//UNSTACKABLE TIMED//
	//===================//
	_ref_status._val_status_lifetime = max(
		_ref_status._val_status_lifetime,
		_val_lifetime
	);

	_ref_status._val_status_lifetime_max = max(
		_ref_status._val_status_lifetime_max,
		_val_lifetime
	);

	return true;
}