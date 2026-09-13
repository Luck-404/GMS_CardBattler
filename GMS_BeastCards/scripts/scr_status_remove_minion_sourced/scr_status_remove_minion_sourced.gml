//===============================================================================//
//
// SCRIPT: SCR_STATUS_REMOVE_MINION_SOURCED
// FUNCTION: Removes every Status sourced by one exact Minion from all battle
//           Beasts. Runs each matching Status's normal DEATH cleanup.
//
// ARGUMENTS: _ref_minion is the exact source Minion reference whose Statuses
//            should be removed.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_status_remove_minion_sourced(_ref_minion){

	//-----------------------//
	//VALIDATE MINION SOURCE//
	//-----------------------//
	if (_ref_minion == undefined){
		return;
	}

	//==================//
	//GET BEAST LISTS//
	//==================//
	var _arr_beast_lists = [];

	if (instance_exists(obj_battle_player_controller)){
		array_push(_arr_beast_lists,obj_battle_player_controller._list_beasts);
	}

	if (instance_exists(obj_battle_enemy_controller)){
		array_push(_arr_beast_lists,obj_battle_enemy_controller._list_beasts);
	}

	//=====================//
	//CHECK ALL BEASTS//
	//=====================//
	for (var _it_team = 0;_it_team < array_length(_arr_beast_lists);_it_team++){

		var _list_beasts = _arr_beast_lists[_it_team];

		if (!ds_exists(_list_beasts,ds_type_list)){
			continue;
		}

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (!ds_exists(_ref_beast._list_statuses,ds_type_list)){
				continue;
			}

			//=========================//
			//CHECK SOURCE STATUSES//
			//=========================//
			for (var _it_status = ds_list_size(_ref_beast._list_statuses) - 1;_it_status >= 0;_it_status--){

				var _ref_status = ds_list_find_value(_ref_beast._list_statuses,_it_status);

				if (!instance_exists(_ref_status)){
					continue;
				}

				if (_ref_status._ref_source_minion != _ref_minion){
					continue;
				}

				//----------------//
				//REMOVE STATUS//
				//----------------//
				if (_ref_status._scr_status != undefined){
					_ref_status._scr_status("DEATH",_ref_status);
				}
				else{
					scr_status_destroy(_ref_status);
				}
			}
		}
	}
}