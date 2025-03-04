//////////////////////////////////////////////////////////////////////
//						SCR_CARDS_CLEANUP							//
//																	//
// > AT THE END OF AN ENCOUNTER, CLEANLY PUT THE CARDS FROM THE		//
//   HAND, DISCARD, AND EXHAUST BACK INTO THE PLAYER'S DECK.		//
//////////////////////////////////////////////////////////////////////
function scr_cards_cleanup(){
	//put all hand cards into discard
	scr_discard_hand();
	
	//move discard into deck
	scr_shuffle();
	
    // move exhausted into deck
    if (global.player_exhaust_pile != -1 && ds_list_size(global.player_exhaust_pile) > 0) {			
        for (var _i = 0; _i < ds_list_size(global.player_exhaust_pile); _i++) {
            var _ref_card = ds_list_find_value(global.player_exhaust_pile, _i);
			// Return the card to the deck
            ds_list_add(global.player_deck, _ref_card);		
        }
		// Clear the current hand
        ds_list_clear(global.player_exhaust_pile);  		
    }	
}