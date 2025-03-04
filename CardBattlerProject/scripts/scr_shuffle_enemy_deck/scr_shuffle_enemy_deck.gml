//////////////////////////////////////////////////////////////////////
//					SCR_SHUFFLE_ENEMY_DECK							//
//																	//
// > TAKE ALL CARDS FROM ENEMY DISCARD PILE AND PLACE INTO THE DECK //
// THEN RANDOMIZE THEIR DECK										//
//////////////////////////////////////////////////////////////////////
function scr_shuffle_enemy_deck(_ref_unit){
	var _unit_deck = _ref_unit._deck;
	var _unit_discard = _ref_unit._discard;
    // Reshuffle the discard back into your overall deck			
    if (_unit_discard != -1 && ds_list_size(_unit_discard) > 0) {			
        for (var _i = 0; _i < ds_list_size(_unit_discard); _i++) {
            var _ref_card = ds_list_find_value(_unit_discard, _i);
			// Return the card to the deck
            ds_list_add(_unit_deck, _ref_card);		
        }
		// Clear the current hand
        ds_list_clear(_unit_discard);  		
    }	
}