//===============================================================================//
//
// SCRIPT: SCR_GET_TEAM_AVERAGE_SPEED
// FUNCTION: Returns the average current Speed of all living Beasts in a team.
//           Ignores invalid or defeated Beast references.
//           Returns 0 when the team contains no living Beasts.
//
//===============================================================================//

function scr_get_team_average_speed(_list_beasts_alive){

	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return 0;
	}

	var _val_speed_total = 0;
	var _ct_beasts = 0;

	for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts_alive); _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (_ref_beast._str_list != "ALIVE" || _ref_beast._val_cur_hp <= 0){
			continue;
		}

		_val_speed_total += scr_get_battle_beast_speed(_ref_beast);
		_ct_beasts++;
	}

	if (_ct_beasts <= 0){
		return 0;
	}

	return _val_speed_total / _ct_beasts;
}