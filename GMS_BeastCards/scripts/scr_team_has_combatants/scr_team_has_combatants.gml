//===============================================================================//
//
// SCRIPT: SCR_TEAM_HAS_COMBATANTS
// FUNCTION: Returns whether a team has any living combatants remaining.
//           Banished Beasts still count as living for battle-end detection.
//
//===============================================================================//

function scr_team_has_combatants(_str_team){

	var _list_beasts;

	if (_str_team == "PLAYER"){
		_list_beasts = obj_battle_player_controller._list_beasts;
	}
	else{
		_list_beasts = obj_battle_enemy_controller._list_beasts;
	}

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts); _it_beast++){

		var _ref_beast =
			ds_list_find_value(
				_list_beasts,
				_it_beast
			);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._val_cur_hp <= 0){
			continue;
		}

		if (
			_ref_beast._str_list == "ALIVE" ||
			_ref_beast._str_list == "BANISHED"
		){
			return true;
		}
	}

	return false;
}