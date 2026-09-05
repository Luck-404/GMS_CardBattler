//===============================================================================//
//
// SCRIPT: SCR_APPLY_ANCHOR_STONE_PASSIVE
// FUNCTION: Applies one Anchor Stone's source-bound Immovable status
//           to every living allied Beast.
//
//===============================================================================//

function scr_apply_anchor_stone_passive(_ref_source_minion){

	if (!instance_exists(_ref_source_minion)){
		return false;
	}

	var _list_allies =
		undefined;

	if (_ref_source_minion._str_team == "PLAYER"){

		_list_allies =
			obj_battle_player_controller
				._list_beasts_alive;
	}
	else{

		_list_allies =
			obj_battle_enemy_controller
				._list_beasts_alive;
	}

	for (
		var _it_ally = 0;
		_it_ally < ds_list_size(_list_allies);
		_it_ally++
	){

		var _ref_ally =
			ds_list_find_value(
				_list_allies,
				_it_ally
			);

		if (!instance_exists(_ref_ally)){
			continue;
		}

		scr_status_buff_anchor_stone(
			"APPLY",
			undefined,
			_ref_source_minion,
			_ref_ally
		);
	}

	return true;
}