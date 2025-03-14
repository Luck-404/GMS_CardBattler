//////////////////////////////////////////////////////////////////////
//							SCR_DRAW_CARDS							//
//																	//
// > DRAWS X CARDS FROM THE PLAYER DECK TO THE PLAYER'S HAND		//
//////////////////////////////////////////////////////////////////////
function scr_draw_cards(_amount) {
    audio_play_sound(snd_shuffle, 0, false);
    
    // Base position and spacing for cards
    var _base_x = 790;
    var _card_spacing = 15;
    var _card_width = 160;
    
    // Get the number of cards already in hand
    var _current_hand_size = ds_list_size(global.player_hand);
    
    // Draw new cards
    for (var _i = 0; _i < _amount; _i++) {
        // Check if there are cards left in the deck
        if (ds_list_size(global.player_encounter_deck) > 0) {
            // Randomly select a card from the deck
            var _index = irandom(ds_list_size(global.player_encounter_deck) - 1);
            var _ref_card = ds_list_find_value(global.player_encounter_deck, _index);

            // Add to the player's hand first to get an updated size
            ds_list_add(global.player_hand, _ref_card);
            _current_hand_size = ds_list_size(global.player_hand);
            
            // Calculate the total width including spacing
            var _total_width = (_current_hand_size * _card_width) + ((_current_hand_size - 1) * _card_spacing);
            var _start_x = _base_x - (_total_width / 2) + (_card_width / 2);
            
            // Assign x positions to all cards
            for (var _j = 0; _j < _current_hand_size; _j++) {
                var _card = ds_list_find_value(global.player_hand, _j);
                _card.x = _start_x + (_j * (_card_width + _card_spacing));
            }
            
            // Update list status
            _ref_card._list = "hand";
            
            // Remove from the deck
            ds_list_delete(global.player_encounter_deck, _index);
        }
    }
}