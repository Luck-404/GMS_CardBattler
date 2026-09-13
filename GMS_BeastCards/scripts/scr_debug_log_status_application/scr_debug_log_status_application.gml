//===============================================================================//
//
// SCRIPT: SCR_DEBUG_LOG_STATUS_APPLICATION
// FUNCTION: Logs a successful host-bound Status application or refresh.
//           Distinguishes first applications, added stacks, and refreshes.
//
// ARGUMENTS: _ref_target is the affected battle Beast.
//            _ref_status is the successfully applied Status instance.
//            _ct_previous_stacks is the stack count before application.
//            _val_previous_lifetime is the lifetime before application.
//            _str_origin identifies the Status dispatcher.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_debug_log_status_application(_ref_target,_ref_status,_ct_previous_stacks=0,_val_previous_lifetime=undefined,_str_origin=""){

	//================//
	//VALIDATE DATA//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

	if (!instance_exists(_ref_status)){
		return;
	}

	if (!is_struct(_ref_target._ref_unit)){
		return;
	}

	//================//
	//GET STATUS DATA//
	//================//
	var _str_status_name = string_upper(_ref_status._str_status_name);
	var _str_status_type = string_upper(_ref_status._str_status_type);

	var _ct_current_stacks = max(1,_ref_status._ct_status_stacks);
	var _ct_added_stacks = max(0,_ct_current_stacks - _ct_previous_stacks);

	var _str_lifetime = "INFINITE";

	if (!_ref_status._flag_status_infinite){
		_str_lifetime = string(_ref_status._val_status_lifetime);
	}

	//================//
	//GET TARGET DATA//
	//================//
	var _str_team = string_upper(_ref_target._str_team);
	var _str_beast_name = string_upper(_ref_target._ref_unit._str_beast_name);
	var _val_level = _ref_target._ref_unit._val_beast_level;

	//================//
	//BUILD MESSAGE//
	//================//
	var _str_message = "";

	//------------------//
	//NEW STACKED STATUS//
	//------------------//
	if (_ref_status._flag_status_stackable && _ct_added_stacks > 0){

		_str_message =
			_str_team + " " +
			_str_beast_name +
			" (LVL " + string(_val_level) + ")" +
			" GAINED " + string(_ct_added_stacks) +
			(_ct_added_stacks == 1 ? " STACK" : " STACKS") +
			" OF " + _str_status_name +
			" | TOTAL: " + string(_ct_current_stacks) +
			" | LIFETIME: " + _str_lifetime;
	}

	//----------------//
	//NEW STATUS//
	//----------------//
	else if (_ct_previous_stacks <= 0){

		_str_message =
			_str_team + " " +
			_str_beast_name +
			" (LVL " + string(_val_level) + ")" +
			" GAINED " + _str_status_name +
			" | TYPE: " + _str_status_type +
			" | LIFETIME: " + _str_lifetime;
	}

	//----------------//
	//REFRESH STATUS//
	//----------------//
	else{

		_str_message =
			_str_team + " " +
			_str_beast_name +
			" (LVL " + string(_val_level) + ")" +
			" REFRESHED " + _str_status_name +
			" | LIFETIME: " + _str_lifetime;
	}

	//================//
	//WRITE STATUS LOG//
	//================//
	scr_debug_log(
		"BATTLE",
		"STATUS",
		_ref_target,
		_str_message,
		"BATTLE",
		_str_origin
	);
}