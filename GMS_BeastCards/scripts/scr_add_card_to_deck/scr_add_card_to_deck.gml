//===============================================================================//
//
// SCRIPT: SCR_ADD_CARD_TO_DECK
// FUNCTION: Adds a card struct to the player deck if there is room.
//           Adds the card struct to the player library if the deck is full.
//           Marks the card as obtained in the logbook.
//
//===============================================================================//

function scr_add_card_to_deck(_stct_new_card){

	//—------------------------------------------------------------------------------//
	// VALIDATE CARD
	//—------------------------------------------------------------------------------//
	if (_stct_new_card == undefined){
		show_debug_message("CARD ERROR: Tried to add undefined card to deck.");
		return false;
	}

	if (!variable_struct_exists(_stct_new_card,"_str_card_name")){
		show_debug_message("CARD ERROR: Tried to add card with no _str_card_name.");
		return false;
	}

	//—------------------------------------------------------------------------------//
	// ADD TO DECK OR LIBRARY
	//—------------------------------------------------------------------------------//
	if (ds_list_size(global.list_player_deck) < 30){
		ds_list_add(global.list_player_deck,_stct_new_card);
	}
	else{
		ds_list_add(global.list_player_library,_stct_new_card);
	}

	//—------------------------------------------------------------------------------//
	// UPDATE LOGBOOK
	//—------------------------------------------------------------------------------//
	if (variable_global_exists("map_logbook_cards")){

		var _str_card_id = "";

		if (variable_struct_exists(_stct_new_card,"_str_card_id")){
			_str_card_id = _stct_new_card._str_card_id;
		}
		else{
			_str_card_id = string_upper(string_replace_all(_stct_new_card._str_card_name," ","_"));
		}

		scr_logbook_mark_card_obtained(_str_card_id);
	}

	return true;
}