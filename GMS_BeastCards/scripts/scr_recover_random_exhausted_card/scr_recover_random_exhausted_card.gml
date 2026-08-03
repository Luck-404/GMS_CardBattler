//===============================================================================//
//
// SCRIPT: SCR_RECOVER_RANDOM_EXHAUSTED_CARD
// FUNCTION: Returns one random exhausted card matching a color to the draw pile.
//           Returns the recovered card reference or undefined if none qualify.
//
//===============================================================================//

function scr_recover_random_exhausted_card(_str_color){

	var _list_exhaust =
		obj_battle_player_controller._list_battle_exhaust;

	var _arr_candidates = [];

	//------------------//
	//BUILD CANDIDATES//
	//------------------//
	for (
		var _it_card = 0;
		_it_card < ds_list_size(_list_exhaust);
		_it_card++
	){

		var _ref_card =
			ds_list_find_value(
				_list_exhaust,
				_it_card
			);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (_ref_card._ref_card == undefined){
			continue;
		}

		var _arr_colors =
			_ref_card._ref_card._arr_card_colors;

		var _flag_color_match = false;

		for (
			var _it_color = 0;
			_it_color < array_length(_arr_colors);
			_it_color++
		){

			if (_arr_colors[_it_color] == _str_color){
				_flag_color_match = true;
				break;
			}
		}

		if (!_flag_color_match){
			continue;
		}

		array_push(_arr_candidates,_ref_card);
	}

	if (array_length(_arr_candidates) <= 0){
		return undefined;
	}

	//---------------//
	//SELECT RANDOM//
	//---------------//
	var _ref_recovered =
		_arr_candidates[
			irandom(
				array_length(_arr_candidates) - 1
			)
		];

	//--------------------//
	//REMOVE FROM EXHAUST//
	//--------------------//
	var _it_exhaust =
		ds_list_find_index(
			_list_exhaust,
			_ref_recovered
		);

	if (_it_exhaust != -1){
		ds_list_delete(_list_exhaust,_it_exhaust);
	}

	//-----------------//
	//RETURN TO DECK//
	//-----------------//
	ds_list_add(
		obj_battle_player_controller._list_battle_deck,
		_ref_recovered
	);

	_ref_recovered._str_location =
		"DECK";

	return _ref_recovered;
}