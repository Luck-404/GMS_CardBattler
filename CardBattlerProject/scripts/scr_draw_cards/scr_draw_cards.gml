//////////////////////////////////////////////////////////////////////
//							SCR_DRAW_CARDS							//
//																	//
// > DRAWS X CARDS FROM THE PLAYER DECK TO THE PLAYER'S HAND		//
//////////////////////////////////////////////////////////////////////
function scr_draw_cards(_amount) {
    audio_play_sound(snd_shuffle, 0, false);
    
    // Base position and spacing for cards
    var _base_x = 500;
    var _card_spacing = 200;
    
    // Get the number of cards already in hand
    var _current_hand_size = ds_list_size(global.player_hand);

    // Draw new cards
    for (var _i = 0; _i < _amount; _i++) {
        // Check if there are cards left in the deck
        if (ds_list_size(global.player_encounter_deck) > 0) {
            // Randomly select a card from the deck
            var _index = irandom(ds_list_size(global.player_encounter_deck) - 1);
            var _ref_card = ds_list_find_value(global.player_encounter_deck, _index);

            // Dynamically adjust x position based on how many are already in hand
            _ref_card.x = _base_x + (_card_spacing * _current_hand_size);
            _current_hand_size++; // Increment to track the next card position
            
            // Update list status
            _ref_card._list = "hand";

            // Add to the player's hand
            ds_list_add(global.player_hand, _ref_card);
            // Remove from the deck
            ds_list_delete(global.player_encounter_deck, _index);
        }
    }
}