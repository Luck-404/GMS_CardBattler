//===============================================================================//
//
// SCRIPT: SCR_REFRESH_BATTLE_FORMATION
// FUNCTION: Reindexes and repositions active Beasts on one team.
//           Used after structural formation changes such as Banish.
//           Does not use normal gameplay reposition restrictions.
//
//===============================================================================//

function scr_refresh_battle_formation(_str_team){

	var _list_beasts;

	if (_str_team == "PLAYER"){
		_list_beasts = obj_battle_player_controller._list_beasts_alive;
	}
	else{
		_list_beasts = obj_battle_enemy_controller._list_beasts_alive;
	}

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		_ref_beast._val_pos =
			_it_beast;

		_ref_beast.x =
			_ref_beast.hscr_get_battle_x(
				_ref_beast._str_team,
				_it_beast
			);

		scr_reposition_minions(_ref_beast);
		scr_reposition_statuses(_ref_beast);
	}
}