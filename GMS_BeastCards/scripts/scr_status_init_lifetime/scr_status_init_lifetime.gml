//===============================================================================//
//
// SCRIPT: SCR_STATUS_INIT_LIFETIME
// FUNCTION: Initializes status duration metadata.
//           Applies the status's fixed stacking and infinite-duration rules.
//
//===============================================================================//
function scr_status_init_lifetime(_ref_status,_val_lifetime,_flag_stackable,_flag_infinite){

	if (!instance_exists(_ref_status)){
		return false;
	}

	_ref_status._flag_status_stackable =
		_flag_stackable;

	_ref_status._flag_status_infinite =
		_flag_infinite;

	//----------------//
	//INFINITE STATUS//
	//----------------//
	if (_flag_infinite){

		_ref_status._val_status_lifetime =
			-1;

		_ref_status._val_status_lifetime_max =
			-1;

		return true;
	}

	//-------------//
	//TIMED STATUS//
	//-------------//
	_val_lifetime =
		max(1,_val_lifetime);

	_ref_status._val_status_lifetime =
		_val_lifetime;

	_ref_status._val_status_lifetime_max =
		_val_lifetime;

	return true;
}