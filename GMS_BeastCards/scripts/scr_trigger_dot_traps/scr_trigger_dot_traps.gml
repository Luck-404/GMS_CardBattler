//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_DOT_TRAPS
// FUNCTION: Checks Traps attached to a Beast after a DoT is successfully applied.
//           Activates DOT_THRESHOLD Traps whose conditions are satisfied.
//
//===============================================================================//
function scr_trigger_dot_traps(_ref_target){

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!variable_instance_exists(_ref_target,"_list_traps")){
		return false;
	}

	//-----------------------//
	//CHECK ATTACHED TRAPS//
	//-----------------------//
	for (
		var _it_trap = ds_list_size(_ref_target._list_traps) - 1;
		_it_trap >= 0;
		_it_trap--
	){

		var _ref_trap = ds_list_find_value(
			_ref_target._list_traps,
			_it_trap
		);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "DOT_THRESHOLD"){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_triggered = _ref_trap._scr_trap(
			"TRIGGER",
			_ref_trap,
			undefined,
			_ref_target,
			undefined
		);

		if (_flag_triggered){
			return true;
		}
	}

	return false;
}