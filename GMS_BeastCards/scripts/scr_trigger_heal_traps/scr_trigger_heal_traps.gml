//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_HEAL_TRAPS
// FUNCTION: Checks Traps attached to a Beast before that Beast is healed.
//           Activates the first valid HEALED Trap.
//           Returns true when the incoming healing should be cancelled.
//
//===============================================================================//
function scr_trigger_heal_traps(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (!variable_instance_exists(_ref_target,"_list_traps")){
		return false;
	}

	//-----------------------//
	//CHECK ATTACHED TRAPS//
	//-----------------------//
	for (var _it_trap = 0; _it_trap < ds_list_size(_ref_target._list_traps); _it_trap++){

		var _ref_trap = ds_list_find_value(_ref_target._list_traps,_it_trap);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "HEALED"){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_cancel_heal = _ref_trap._scr_trap(
			"TRIGGER",
			_ref_trap,
			undefined,
			_ref_target,
			undefined
		);

		if (_flag_cancel_heal){
			return true;
		}
	}

	return false;
}