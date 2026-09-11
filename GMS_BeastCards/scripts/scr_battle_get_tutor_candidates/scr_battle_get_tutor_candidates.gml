//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_TUTOR_CANDIDATES
// FUNCTION: Returns battle Card instances in the player's draw pile whose
//           Primary Card Type matches the requested type.
//
// INPUT:    _str_primary_card_type - Primary Card Type required for selection.
// USES:     Player battle Deck and each Card instance's backing Card struct.
//
//===============================================================================//

function scr_battle_get_tutor_candidates(_str_primary_card_type){

	#region TUTOR CANDIDATES

	//----------------//
	//GET BATTLE DECK//
	//----------------//
	var _arr_candidates = [];
	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _ct_deck = ds_list_size(_list_deck);

	//------------------//
	//CHECK DECK CARDS//
	//------------------//
	for (var _it_card = 0; _it_card < _ct_deck; _it_card++){

		var _ref_card = ds_list_find_value(_list_deck,_it_card);

		if (!instance_exists(_ref_card)){
			continue;
		}

		if (_ref_card._str_location != "DECK"){
			continue;
		}

		if (!is_struct(_ref_card._ref_card)){
			continue;
		}

		var _stct_card = _ref_card._ref_card;

		if (_stct_card._str_card_type != _str_primary_card_type){
			continue;
		}

		array_push(_arr_candidates,_ref_card);
	}

	#endregion

	return _arr_candidates;
}