//===============================================================================//
//
// SCRIPT: SCR_CC_UPDATE_BANISHED_BEASTS
// FUNCTION: Advances Banish durations at normal side-turn boundaries.
//           Checks Banished Beasts on both teams.
//           Returns a Beast to battle when its Banish countdown expires.
//
//===============================================================================//

function scr_cc_update_banished_beasts(){

	//----------------------//
	//VALIDATE CONTROLLERS//
	//----------------------//
	if (!instance_exists(obj_battle_player_controller)){
		return;
	}

	if (!instance_exists(obj_battle_enemy_controller)){
		return;
	}

	//================//
	//GET TEAM LISTS//
	//================//
	var _arr_team_lists = [
		obj_battle_player_controller._list_beasts,
		obj_battle_enemy_controller._list_beasts
	];

	//========================//
	//UPDATE BANISHED BEASTS//
	//========================//
	for (var _it_team = 0;_it_team < array_length(_arr_team_lists);_it_team++){

		var _list_beasts = _arr_team_lists[_it_team];

		if (!ds_exists(_list_beasts,ds_type_list)){
			continue;
		}

		for (var _it_beast = 0;_it_beast < ds_list_size(_list_beasts);_it_beast++){

			var _ref_beast = ds_list_find_value(_list_beasts,_it_beast);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (_ref_beast._str_list != "BANISHED"){
				continue;
			}

			//----------------//
			//GET BANISH//
			//----------------//
			var _ref_banish = scr_status_check("BANISH",_ref_beast);

			if (_ref_banish == -1){
				continue;
			}

			if (!instance_exists(_ref_banish)){
				continue;
			}

			//-------------------//
			//ADVANCE COUNTDOWN//
			//-------------------//
			_ref_banish._ct_banish_turns_remaining--;

			//----------------//
			//RETURN BEAST//
			//----------------//
			if (_ref_banish._ct_banish_turns_remaining <= 0){

				scr_status_cc_banish(
					"DEATH",
					_ref_banish
				);
			}
		}
	}
}