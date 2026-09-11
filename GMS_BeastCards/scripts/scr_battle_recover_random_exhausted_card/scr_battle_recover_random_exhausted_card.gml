//===============================================================================//
//
// SCRIPT: SCR_BATTLE_RECOVER_RANDOM_EXHAUSTED_CARD
// FUNCTION: Recovers one random exhausted Card matching the requested color.
//           Moves the selected Card from the player's Exhaust pile back into
//           the battle Deck and returns its instance reference.
//
// INPUT:    _str_color - Card color required for the recovery.
// USES:     Player battle Exhaust and Deck lists and each Card's backing
//           Card struct and color array.
//
//===============================================================================//

function scr_battle_recover_random_exhausted_card(_str_color){

	#region CANDIDATES

	//----------------//
	//GET CARD LISTS//
	//----------------//
	var _list_exhaust = obj_battle_player_controller._list_battle_exhaust;
	var _list_deck = obj_battle_player_controller._list_battle_deck;

	//------------------//
	//BUILD CANDIDATES//
	//------------------//
	var _arr_candidates = [];

	for (var _it_card = 0; _it_card < ds_list_size(_list_exhaust); _it_card++){

		var _ref_card = ds_list_find_value(_list_exhaust,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (!is_struct(_ref_card._ref_card)){
			continue;
		}

		var _arr_card_colors = _ref_card._ref_card._arr_card_colors;

		if (!is_array(_arr_card_colors)){
			continue;
		}

		var _flag_color_match = false;

		for (var _it_color = 0; _it_color < array_length(_arr_card_colors); _it_color++){

			if (_arr_card_colors[_it_color] == _str_color){
				_flag_color_match = true;
				break;
			}
		}

		if (!_flag_color_match){
			continue;
		}

		array_push(_arr_candidates,_ref_card);
	}

	//-------------------//
	//NO VALID CANDIDATE//
	//-------------------//
	if (array_length(_arr_candidates) <= 0){
		return undefined;
	}

	#endregion

	#region RECOVER CARD

	//------------------//
	//SELECT RANDOM CARD//
	//------------------//
	var _ref_recovered_card = _arr_candidates[irandom(array_length(_arr_candidates) - 1)];

	//--------------------//
	//REMOVE FROM EXHAUST//
	//--------------------//
	var _it_exhaust = ds_list_find_index(_list_exhaust,_ref_recovered_card);

	if (_it_exhaust != -1){
		ds_list_delete(_list_exhaust,_it_exhaust);
	}

	//----------------//
	//RETURN TO DECK//
	//----------------//
	ds_list_add(_list_deck,_ref_recovered_card);

	_ref_recovered_card._str_location = "DECK";

	#endregion

	return _ref_recovered_card;
}