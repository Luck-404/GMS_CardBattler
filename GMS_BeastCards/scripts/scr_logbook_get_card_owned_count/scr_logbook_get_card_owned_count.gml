//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_GET_CARD_OWNED_COUNT
// FUNCTION: Returns the current owned count for a card id.
//           Counts matching cards in both the player deck and library.
//           Does not modify logbook state.
//
// ARGUMENTS: _str_card_id is the card id to count.
// RETURNS: Total number of matching owned cards.
//
//===============================================================================//

function scr_logbook_get_card_owned_count(_str_card_id){

	//================//
	//LOCAL METHODS//
	//================//

	//-------------------------------------------------------------------------------//
	// HSCR_LOGBOOK_COUNT_CARD_IN_LIST
	// FUNCTION: Counts matching cards within a supplied DS list.
	//
	// ARGUMENTS: _list_cards is the card list; _str_id is the card id to count.
	// RETURNS: Number of matching cards in the supplied list.
	//
	//-------------------------------------------------------------------------------//
	function hscr_logbook_count_card_in_list(_list_cards,_str_id){

		if (!ds_exists(_list_cards,ds_type_list)){
			return 0;
		}

		var _ct_owned = 0;

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

	//================//
	//COUNT OWNED CARDS//
	//================//
	var _ct_deck = hscr_logbook_count_card_in_list(global.list_player_deck,_str_card_id);
	var _ct_library = hscr_logbook_count_card_in_list(global.list_player_library,_str_card_id);

	return _ct_deck + _ct_library;
}