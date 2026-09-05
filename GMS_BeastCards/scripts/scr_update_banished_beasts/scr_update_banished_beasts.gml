//===============================================================================//
//
// SCRIPT: SCR_UPDATE_BANISHED_BEASTS
// FUNCTION: Advances Banish duration at normal side-turn boundaries.
//           Returns Beasts whose Banish duration has expired.
//
//===============================================================================//

function scr_update_banished_beasts(){

	var _arr_team_lists = [
		obj_battle_player_controller._list_beasts,
		obj_battle_enemy_controller._list_beasts
	];

	for (var _it_team = 0; _it_team < array_length(_arr_team_lists); _it_team++){

		var _list_beasts =
			_arr_team_lists[_it_team];

		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts); _it_beast++){

			var _ref_beast =
				ds_list_find_value(
					_list_beasts,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._str_list != "BANISHED"){
				continue;
			}

			var _ref_banish =
				scr_check_for_status(
					"BANISH",
					_ref_beast
				);

			if (_ref_banish == -1){
				continue;
			}

			_ref_banish._ct_banish_turns_remaining--;

			if (_ref_banish._ct_banish_turns_remaining <= 0){

				scr_status_cc_banish(
					"DEATH",
					_ref_banish
				);
			}
		}
	}
}