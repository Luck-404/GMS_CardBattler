//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_DEATH_TRAPS
// FUNCTION: Checks and activates DEATH Traps attached to a defeated Beast.
//           Runs before the Beast leaves its alive formation so adjacent
//           targeting can still use its original position.
//
//===============================================================================//
function scr_trigger_death_traps(_ref_host){

	if (!instance_exists(_ref_host)){
		return 0;
	}

	if (!variable_instance_exists(_ref_host,"_list_traps")){
		return 0;
	}

	var _ct_triggered = 0;

	//-------------------//
	//CHECK DEATH TRAPS//
	//-------------------//
	for (
		var _it_trap = ds_list_size(_ref_host._list_traps) - 1;
		_it_trap >= 0;
		_it_trap--
	){

		var _ref_trap = ds_list_find_value(
			_ref_host._list_traps,
			_it_trap
		);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "DEATH"){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_triggered = _ref_trap._scr_trap(
			"TRIGGER",
			_ref_trap,
			undefined,
			_ref_host,
			undefined
		);

		if (_flag_triggered){
			_ct_triggered++;
		}
	}

	return _ct_triggered;
}