//===============================================================================//
//
// SCRIPT: SCR_TRAP_DESTROY
// FUNCTION: Removes a Trap from its owning Trap collection.
//           Team Traps are removed from the battle-wide team Trap array.
//           Hosted Traps are removed from their host Beast's Trap list.
//           Destroys the exact Trap instance afterward.
//
// ARGUMENTS: _ref_trap is the Trap instance to remove and destroy.
// RETURNS: True when a valid Trap instance is destroyed; otherwise false.
//
//===============================================================================//

function scr_trap_destroy(_ref_trap){

	//----------------//
	//VALIDATE TRAP//
	//----------------//
	if (!instance_exists(_ref_trap)){
		return false;
	}

	var _ref_host = _ref_trap._ref_host;

	//================//
	//TEAM TRAP//
	//================//
	if (_ref_trap._str_trap_scope == "TEAM"){

		if (
			instance_exists(obj_battle_turn_controller) &&
			variable_instance_exists(obj_battle_turn_controller,"_arr_team_traps") &&
			is_array(obj_battle_turn_controller._arr_team_traps)
		){

			for (var _it_trap = array_length(obj_battle_turn_controller._arr_team_traps) - 1;_it_trap >= 0;_it_trap--){

				if (obj_battle_turn_controller._arr_team_traps[_it_trap] != _ref_trap){
					continue;
				}

				array_delete(
					obj_battle_turn_controller._arr_team_traps,
					_it_trap,
					1
				);

				break;
			}
		}

		instance_destroy(_ref_trap);

		return true;
	}

	//================//
	//HOSTED TRAP//
	//================//
	if (
		instance_exists(_ref_host) &&
		variable_instance_exists(_ref_host,"_list_traps") &&
		ds_exists(_ref_host._list_traps,ds_type_list)
	){

		var _it_trap = ds_list_find_index(_ref_host._list_traps,_ref_trap);

		if (_it_trap != -1){

			ds_list_delete(
				_ref_host._list_traps,
				_it_trap
			);
		}
	}

	instance_destroy(_ref_trap);

	return true;
}