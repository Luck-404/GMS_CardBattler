//===============================================================================//
//
// SCRIPT: SCR_DESTROY_TRAP
// FUNCTION: Removes a Trap from its host Beast.
//           Deletes the host list reference before destroying the Trap instance.
//
//===============================================================================//

function scr_destroy_trap(_ref_trap){

	if (!instance_exists(_ref_trap)){
		return false;
	}

	var _ref_host =
		_ref_trap._ref_host;

	//----------------//
	//TEAM TRAP//
	//----------------//
	if (_ref_trap._str_trap_scope == "TEAM"){

	for (
		var _it_trap =
			array_length(obj_battle_turn_controller._arr_team_traps) - 1;
		_it_trap >= 0;
		_it_trap--
	){

		if (
			obj_battle_turn_controller._arr_team_traps[_it_trap] ==
			_ref_trap
		){

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



	if (instance_exists(_ref_host)){

		var _it_trap =
			ds_list_find_index(
				_ref_host._list_traps,
				_ref_trap
			);

		if (_it_trap != -1){

			ds_list_delete(
				_ref_host._list_traps,
				_it_trap
			);
		}
	}

	instance_destroy(
		_ref_trap
	);

	return true;
}