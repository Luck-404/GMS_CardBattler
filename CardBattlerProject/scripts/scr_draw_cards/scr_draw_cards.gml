/////////////////////////////////////////////////////////////////////////////////////////////
// HELPER SCRIPT TO REDRAW ALL CARDS ON PRESSING "D" (DEVELOPER) & AT THE END OF THE ROUND //
/////////////////////////////////////////////////////////////////////////////////////////////
function scr_draw_cards() {
	audio_play_sound(snd_shuffle,0,false);
    // First, remove any previous card instances and reshuffle them back into the deck
    if (global.current_hand != undefined) {
		show_debug_message("!!=== SCR_DRAW_CARDS: REMOVING OLD CARD OBJECTS... ===!!");				
        // Destroy any existing cards in hand (obj_cards)
        with (obj_card) {
            instance_destroy();
        }
		show_debug_message("!!=== SCR_DRAW_CARDS: REMOVED OLD CARD OBJECTS! ===!!");		

        // Reshuffle the current hand back into your overall deck
		show_debug_message("!!=== SCR_DRAW_CARDS: SHUFFLING HAND CARDS BACK INTO DECK... ===!!");				
        if (global.current_hand != -1 && ds_list_size(global.current_hand) > 0) {			
            for (var _i = 0; _i < ds_list_size(global.current_hand); _i++) {
                var _ref_card = ds_list_find_value(global.current_hand, _i);
				// Return the card to the deck
                ds_list_add(global.card_inventory, _ref_card);  
				show_debug_message("!!=== SCR_DRAW_CARDS: ADDED " + _ref_card[?"name"] + " BACK TO DECK! ===!!");				
            }
			// Clear the current hand
            ds_list_clear(global.current_hand);  
			show_debug_message("!!=== SCR_DRAW_CARDS: CLEARED CURRENT_HAND! ===!!");			
        }
		show_debug_message("!!=== SCR_DRAW_CARDS: SHUFFLED ALL HAND CARDS BACK INTO DECK! ===!!");		



			////////////////////////////////
			// "LOSS" ON NO CARDS TO DRAW //
			////////////////////////////////
		        // Check if there are no cards left in the deck
		        if (ds_list_size(global.card_inventory) == 0) {
		            // If there are no cards left in the deck, and the hand is also empty, transition to saved_room
		            if (ds_list_size(global.current_hand) == 0) {
						show_debug_message("!!=== SCR_GEN_CARDS: EXHAUSTED ALL CARDS! ENDING GAME... ===!!");						
		                global.trigger_loss = true;
		                return;  // Stop the function from proceeding further
		            }
		        }
				
		show_debug_message("!!=== SCR_GEN_CARDS: DRAWING " + string(global.hand_size) +" NEW CARDS... ===!!");	
        // Draw new cards (as many as you can before maximum)
        for (var _i = 0; _i < global.hand_size; _i++) {
			//if you have cards in your overall deck
            if (ds_list_size(global.card_inventory) > 0) {
                // Randomly select a card from the deck
                var _index = irandom(ds_list_size(global.card_inventory) - 1);
                var _ref_card = ds_list_find_value(global.card_inventory, _index);
				show_debug_message("!!=== SCR_GEN_CARDS: FOUND RANDOM CARD " + _ref_card[?"name"] + "! ===!!");		
                // Add card to the hand
                ds_list_add(global.current_hand, _ref_card);
				show_debug_message("!!=== SCR_GEN_CARDS: ADDED CARD TO CURRENT_HAND! ===!!");
                // Remove card from the deck
                ds_list_delete(global.card_inventory, _index);
				show_debug_message("!!=== SCR_GEN_CARDS: REMOVED CARD FROM DECK! ===!!");
                // Create the card instance and update its data
				show_debug_message("!!=== SCR_GEN_CARDS: CREATING NEW CARD OBJECT... ===!!");				
                var _x_pos = room_width / 2;
                var _y_pos = room_height / 2;  
                var _ref_card_instance = instance_create_layer(_x_pos, _y_pos, "GUI", obj_card);
                _ref_card_instance._card_name = _ref_card[? "name"];
                _ref_card_instance._card_desc = _ref_card[? "description"];
                _ref_card_instance._card_cost = _ref_card[? "cost"];
                _ref_card_instance._card_script = _ref_card[? "script"];
                _ref_card_instance._card_sprite = _ref_card[? "sprite"];
				_ref_card_instance._card_target = _ref_card[? "target"];
				_ref_card_instance._card_color = _ref_card[? "color"];
				_ref_card_instance._card_type = _ref_card[? "type"];
				_ref_card_instance._card_spec = _ref_card[? "spec"]
				show_debug_message("!!=== SCR_GEN_CARDS: CREATED NEW CARD OBJECT! ===!!");				
            } else {
				show_debug_message("!!=== SCR_GEN_CARDS: ITERATION " + string(_i) + " DID NOT FIND A CARD TO DRAW FROM THE DECK! ===!!");						
			}
        }
		show_debug_message("!!=== SCR_GEN_CARDS: FINISHED DRAWING CARDS! ===!!");			
    }
}