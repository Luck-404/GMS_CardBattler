//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_TEAM_AVERAGE_SPEED
// FUNCTION: Returns the average current Speed of all living Beasts in a team.
//           Ignores invalid or defeated Beast references.
//           Returns 0 when the team contains no living Beasts.
//
// INPUT:    _list_beasts_alive - Active battle Beast list being averaged.
//
//===============================================================================//

function scr_battle_get_team_average_speed(_list_beasts_alive){

	//---------------//
	//VALIDATE LIST//
	//---------------//
	if (!ds_exists(_list_beasts_alive,ds_type_list)){
		return 0;
	}

	//----------------//
	//AVERAGE SPEED//
	//----------------//
	var _val_speed_total = 0;
	var _ct_beasts = 0;

	var _ct_list_beasts = ds_list_size(_list_beasts_alive);

	for (var _it_beast = 0; _it_beast < _ct_list_beasts; _it_beast++){

		var _ref_beast = ds_list_find_value(_list_beasts_alive,_it_beast);

		if (!instance_exists(_ref_beast)){
			continue;
		}

		if (
			_ref_beast._str_list != "ALIVE" ||
			_ref_beast._val_cur_hp <= 0
		){
			continue;
		}

		_val_speed_total += scr_battle_get_beast_speed(_ref_beast);

		_ct_beasts++;
	}

	//--------------//
	//EMPTY TEAM//
	//--------------//
	if (_ct_beasts <= 0){
		return 0;
	}

	return _val_speed_total / _ct_beasts;
}