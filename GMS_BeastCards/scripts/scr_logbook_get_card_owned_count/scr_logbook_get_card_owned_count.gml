//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_GET_CARD_OWNED_COUNT
// FUNCTION: Returns the current owned count for a card id.
//           Counts matching cards in both player deck and player library.
//           Does not modify logbook state.
//
//===============================================================================//

function scr_logbook_get_card_owned_count(_str_card_id){

	//—------------------------------------------------------------------------------//
	// LOCAL HELPER: COUNT CARDS IN LIST
	//—------------------------------------------------------------------------------//
	function hscr_count_card_in_list(_list_cards,_str_id){

		var _ct_owned = 0;

		if (!ds_exists(_list_cards,ds_type_list)){
			return 0;
		}

		for (var _it_card = 0; _it_card < ds_list_size(_list_cards); _it_card++){

			var _stct_card = ds_list_find_value(_list_cards,_it_card);

			if (_stct_card == undefined){
				continue;
			}

			if (!variable_struct_exists(_stct_card,"_str_card_id")){
				continue;
			}

			if (_stct_card._str_card_id == _str_id){
				_ct_owned++;
			}
		}

		return _ct_owned;
	}

	//—------------------------------------------------------------------------------//
	// COUNT DECK + LIBRARY
	//—------------------------------------------------------------------------------//
	var _ct_deck = hscr_count_card_in_list(global.list_player_deck,_str_card_id);
	var _ct_library = hscr_count_card_in_list(global.list_player_library,_str_card_id);

	return _ct_deck + _ct_library;
}