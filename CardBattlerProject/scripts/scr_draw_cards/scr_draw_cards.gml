//////////////////////////////////////////////////////////////////////
//							SCR_DRAW_CARDS							//
//																	//
// > DRAWS X CARDS FROM THE PLAYER DECK TO THE PLAYER'S HAND		//
//////////////////////////////////////////////////////////////////////
function scr_draw_cards(_amount) {
	audio_play_sound(snd_shuffle,0,false);
	
    // Draw new cards
    for (var _i = 0; _i < _amount; _i++) {
		//if you have cards in your overall deck
        if (ds_list_size(global.player_encounter_deck) > 0) {
            // Randomly select a card from the deck
            var _index = irandom(ds_list_size(global.player_encounter_deck) - 1);
            var _ref_card = ds_list_find_value(global.player_encounter_deck, _index);
			//move card to bottom of screen
			_ref_card.x = 500+(150*_i);
			_ref_card._list = "hand";
				// Add card to the hand
            ds_list_add(global.player_hand, _ref_card);
			    // Remove card from the deck
            ds_list_delete(global.player_encounter_deck, _index);
			
       }
    }	
}