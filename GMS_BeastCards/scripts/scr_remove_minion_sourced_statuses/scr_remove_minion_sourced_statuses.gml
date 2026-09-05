//===============================================================================//
//
// SCRIPT: SCR_REMOVE_MINION_SOURCED_STATUSES
// FUNCTION: Removes every status sourced by one exact Minion
//           from all battle Beasts.
//
//===============================================================================//

function scr_remove_minion_sourced_statuses(_ref_minion){

	if (!instance_exists(_ref_minion)){
		return;
	}

	var _arr_beast_lists = [
		obj_battle_player_controller._list_beasts,
		obj_battle_enemy_controller._list_beasts
	];

	for (
		var _it_team = 0;
		_it_team < array_length(_arr_beast_lists);
		_it_team++
	){

		var _list_beasts =
			_arr_beast_lists[_it_team];

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_beasts);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_beasts,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			for (
				var _it_status =
					ds_list_size(_ref_beast._list_statuses) - 1;
				_it_status >= 0;
				_it_status--
			){

				var _ref_status =
					ds_list_find_value(
						_ref_beast._list_statuses,
						_it_status
					);

				if (!instance_exists(_ref_status)){
					continue;
				}

				if (
					_ref_status._ref_source_minion !=
					_ref_minion
				){
					continue;
				}

				if (_ref_status._scr_status != undefined){

					_ref_status._scr_status(
						"DEATH",
						_ref_status
					);
				}
				else{

					scr_destroy_status(
						_ref_status
					);
				}
			}
		}
	}
}