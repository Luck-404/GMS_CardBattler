//===============================================================================//
//
// SCRIPT: SCR_TRIGGER_HEAL_TRAPS
// FUNCTION: Checks healing-triggered Traps for a target Beast.
//           Supports hosted and teamwide HEALED Traps.
//           BEFORE Traps may cancel the incoming healing.
//           AFTER Traps resolve after the healing has completed.
//
//===============================================================================//

function scr_trigger_heal_traps(_ref_target,_str_phase="BEFORE"){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//======================//
	//CHECK HOSTED TRAPS//
	//======================//
	if (variable_instance_exists(_ref_target,"_list_traps")){

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

			if (_ref_trap._str_trigger_type != "HEALED"){
				continue;
			}

			if (_ref_trap._str_trigger_phase != _str_phase){
				continue;
			}

			if (_ref_trap._scr_trap == undefined){
				continue;
			}

			var _flag_cancel_heal =
				_ref_trap._scr_trap(
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
	}

	//====================//
	//CHECK TEAM TRAPS//
	//====================//
	for (
		var _it_trap =
			array_length(
				obj_battle_turn_controller._arr_team_traps
			) - 1;
		_it_trap >= 0;
		_it_trap--
	){

		var _ref_trap =
			obj_battle_turn_controller
				._arr_team_traps[_it_trap];

		//------------------//
		//CLEAN INVALID TRAP//
		//------------------//
		if (!instance_exists(_ref_trap)){

			array_delete(
				obj_battle_turn_controller._arr_team_traps,
				_it_trap,
				1
			);

			continue;
		}

		if (_ref_trap._flag_triggered){
			continue;
		}

		if (_ref_trap._str_trap_scope != "TEAM"){
			continue;
		}

		if (_ref_trap._str_trigger_type != "HEALED"){
			continue;
		}

		if (_ref_trap._str_trigger_phase != _str_phase){
			continue;
		}

		if (_ref_trap._str_target_team != _ref_target._str_team){
			continue;
		}

		if (_ref_trap._scr_trap == undefined){
			continue;
		}

		var _flag_cancel_heal =
			_ref_trap._scr_trap(
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