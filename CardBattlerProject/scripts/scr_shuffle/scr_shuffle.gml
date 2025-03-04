//////////////////////////////////////////////////////////////////////
//								SCR_SHUFFLE							//
//																	//
// > TAKE ALL CARDS FROM DISCARD PILE AND PLACE INTO THE DECK, THEN //
//   RANDOMIZE THE DECK												//
//////////////////////////////////////////////////////////////////////
function scr_shuffle(){
    // Reshuffle the discard back into your overall deck			
    if (global.player_discard_pile != -1 && ds_list_size(global.player_discard_pile) > 0) {			
        for (var _i = 0; _i < ds_list_size(global.player_discard_pile); _i++) {
            var _ref_card = ds_list_find_value(global.player_discard_pile, _i);
			// Return the card to the deck
            ds_list_add(global.player_deck, _ref_card);		
        }
		// Clear the current hand
        ds_list_clear(global.player_discard_pile);  		
    }	
}