//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_TARGET_TRAPS
// FUNCTION: Checks Traps attached to a Beast when that Beast is directly targeted.
//           Activates the first valid Trap matching the targeting event.
//           Returns true when the incoming action should be cancelled.
//
//===============================================================================//
function scr_trigger_target_traps(_ref_attacker,_ref_target,_stct_card){

	if (!instance_exists(_ref_attacker)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_stct_card == undefined){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_target,
			"_list_traps"
		)
	){
		return false;
	}

	//-----------------------//
	//CHECK ATTACHED TRAPS//
	//-----------------------//
	for (
		var _it_trap = 0;
		_it_trap < ds_list_size(_ref_target._list_traps);
		_it_trap++
	){

		var _ref_trap =
			ds_list_find_value(
				_ref_target._list_traps,
				_it_trap
			);

		if (!instance_exists(_ref_trap)){
			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trigger_type != "TARGETED"){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_cancel_action =
			_ref_trap._scr_trap(
				"TRIGGER",
				_ref_trap,
				_ref_attacker,
				_ref_target,
				_stct_card
			);

		if (_flag_cancel_action){

			scr_battle_vfx_blocked(
				_ref_target
			);

			return true;
		}
	}

	return false;
}