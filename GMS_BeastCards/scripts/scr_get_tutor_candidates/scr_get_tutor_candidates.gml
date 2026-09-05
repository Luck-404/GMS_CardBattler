//===============================================================================//
//
// SCRIPT: SCR_GET_TUTOR_CANDIDATES
// FUNCTION: Returns battle-card instances in the draw pile matching
//           the requested Primary Card Type.
//
//===============================================================================//

function scr_get_tutor_candidates(_str_card_type){

	var _arr_candidates = [];

	var _list_deck =
		obj_battle_player_controller._list_battle_deck;

	for (
		var _it_card = 0;
		_it_card < ds_list_size(_list_deck);
		_it_card++
	){

		var _ref_card =
			ds_list_find_value(_list_deck,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (_ref_card._str_location != "DECK"){
			continue;
		}

		if (!is_struct(_ref_card._ref_card)){
			continue;
		}

		if (_ref_card._ref_card._str_card_type != _str_card_type){
			continue;
		}

		array_push(_arr_candidates,_ref_card);
	}

	return _arr_candidates;
}