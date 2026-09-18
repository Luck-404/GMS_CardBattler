//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_EXHAUSTED_COLOR_CANDIDATES
// FUNCTION: Returns exhausted player Cards matching the requested color.
//           Optionally excludes an exact Card instance.
//           Does not modify either Card pile.
//
// ARGUMENTS: _str_color is the required Card color.
//            _ref_excluded_card is an optional Card to exclude.
// RETURNS: Array of eligible battle Card instances.
//
//===============================================================================//

function scr_battle_get_exhausted_color_candidates(_str_color,_ref_excluded_card=undefined){

	var _arr_candidates = [];

	if (!instance_exists(obj_battle_player_controller)){
		return _arr_candidates;
	}

	var _list_exhaust = obj_battle_player_controller._list_battle_exhaust;

	if (!ds_exists(_list_exhaust,ds_type_list)){
		return _arr_candidates;
	}

	//================//
	//CHECK EXHAUST//
	//================//
	for (var _it_card = 0;_it_card < ds_list_size(_list_exhaust);_it_card++){

		var _ref_card = ds_list_find_value(_list_exhaust,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (_ref_card == _ref_excluded_card){
			continue;
		}

		if (_ref_card._str_location != "EXHAUST"){
			continue;
		}

		if (!is_struct(_ref_card._ref_card)){
			continue;
		}

		//================//
		//CHECK COLOR//
		//================//
		var _arr_colors = _ref_card._ref_card._arr_card_colors;

		if (!is_array(_arr_colors)){
			continue;
		}

		for (var _it_color = 0;_it_color < array_length(_arr_colors);_it_color++){

			if (_arr_colors[_it_color] == _str_color){

				array_push(_arr_candidates,_ref_card);

				break;
			}
		}
	}

	return _arr_candidates;
}