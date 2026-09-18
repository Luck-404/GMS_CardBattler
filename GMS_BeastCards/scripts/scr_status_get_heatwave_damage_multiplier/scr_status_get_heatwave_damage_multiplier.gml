//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_HEATWAVE_DAMAGE_MULTIPLIER
// FUNCTION: Returns a 25% damage multiplier when Heatwave is active
//           and the source Card is Vermilion.
//
// ARGUMENTS: _stct_card is the Card causing the damage.
// RETURNS: 1.25 when eligible; otherwise 1.
//
//===============================================================================//

function scr_status_get_heatwave_damage_multiplier(_stct_card){

	//================//
	//VALIDATE CARD//
	//================//
	if (!is_struct(_stct_card)){
		return 1;
	}

	if (!is_array(_stct_card._arr_card_colors)){
		return 1;
	}

	//================//
	//CHECK WEATHER//
	//================//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return 1;
	}

	var _ref_heatwave = scr_status_check(
		"WEATHER: HEATWAVE",
		global.list_statuses
	);

	if (
		_ref_heatwave == -1 ||
		!instance_exists(_ref_heatwave)
	){
		return 1;
	}

	//================//
	//CHECK CARD COLOR//
	//================//
	for (var _it_color = 0;_it_color < array_length(_stct_card._arr_card_colors);_it_color++){

		if (_stct_card._arr_card_colors[_it_color] == "VERMILION"){
			return 1.25;
		}
	}

	return 1;
}