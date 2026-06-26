//===============================================================================//
//
// SCR_CAST_MINION_EFFECT
// FUNCTION: Casts the effect of a battle minion.
//           Determines friendly and enemy beast lists from the minion team.
//           Executes behavior based on minion name.
//
//===============================================================================//
function scr_cast_minion_effect(_ref_minion){

	var _str_minion_name = _ref_minion._str_name;
	var _str_minion_team = _ref_minion._str_team;

	var _list_enemy;
	var _list_friendly;

	if (_str_minion_team == "PLAYER"){
		_list_friendly = obj_battle_player_controller._list_beasts_alive;
		_list_enemy = obj_battle_enemy_controller._list_beasts_alive;
	}
	else{
		_list_enemy = obj_battle_player_controller._list_beasts_alive;
		_list_friendly = obj_battle_enemy_controller._list_beasts_alive;
	}

	switch(_str_minion_name){

		case "LIFE SPIRIT":
			scr_heal_target(2,_ref_minion._ref_host);
		break;
	}
}