//===============================================================================//
//
// SCRIPT: SCR_STATUS_INIT_LIFETIME
// FUNCTION: Initializes Status duration metadata.
//           Applies the Status's fixed stacking and infinite-duration rules.
//
// ARGUMENTS: _ref_status is the Status being initialized, _val_lifetime is its
//            duration, and the two flags define stacking and infinite duration.
// RETURNS: True when lifetime data is initialized successfully; otherwise false.
//
//===============================================================================//

function scr_status_init_lifetime(_ref_status,_val_lifetime,_flag_stackable,_flag_infinite){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return false;
	}

	//================//
	//STATUS RULES//
	//================//
	_ref_status._flag_status_stackable = _flag_stackable;
	_ref_status._flag_status_infinite = _flag_infinite;

	//=================//
	//INFINITE STATUS//
	//=================//
	if (_flag_infinite){

		_ref_status._val_status_lifetime = -1;
		_ref_status._val_status_lifetime_max = -1;

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

	//================//
	//TIMED STATUS//
	//================//
	_val_lifetime = max(1,_val_lifetime);

	_ref_status._val_status_lifetime = _val_lifetime;
	_ref_status._val_status_lifetime_max = _val_lifetime;

	return true;
}