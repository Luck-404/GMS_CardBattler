//===============================================================================//
//
// SCRIPT: SCR_GET_TARGET_TEAM_LIST
// FUNCTION: Returns the alive Beast list belonging to the supplied target.
//           Supports PLAYER and ENEMY battle teams.
//           Returns undefined when the target or team is invalid.
//
//===============================================================================//

function scr_get_target_team_list(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return undefined;
	}

	if (!variable_instance_exists(_ref_target,"_str_team")){
		return undefined;
	}

	//------------------//
	//PLAYER TARGET TEAM//
	//------------------//
	if (_ref_target._str_team == "PLAYER"){

		if (!instance_exists(obj_battle_player_controller)){
			return undefined;
		}

		return obj_battle_player_controller._list_beasts_alive;
	}

	//-----------------//
	//ENEMY TARGET TEAM//
	//-----------------//
	if (_ref_target._str_team == "ENEMY"){

		if (!instance_exists(obj_battle_enemy_controller)){
			return undefined;
		}

		return obj_battle_enemy_controller._list_beasts_alive;
	}

	return undefined;
}