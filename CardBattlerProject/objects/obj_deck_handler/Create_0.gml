// Global variables for card management
global.hand_size = 3;  // Maximum of 3 cards in the hand
global.current_hand = ds_list_create();  // List to store the current hand
global.exhausted = ds_list_create();  // List to store the exhausted cards
global.card_selected = undefined;  // Variable to store the selected card
global.echo = false;
global.echo_count = 0;

// scr_draw_cards
function scr_draw_cards() {
    // First, remove any previous card instances and reshuffle them back into the deck
    if (global.current_hand != undefined) {
        // Destroy any existing cards in hand (obj_cards)
        with (obj_card) {
            instance_destroy();
        }

        // Reshuffle the current hand back into the deck
        if (global.current_hand != -1 && ds_list_size(global.current_hand) > 0) {
            for (var i = 0; i < ds_list_size(global.current_hand); i++) {
                var card = ds_list_find_value(global.current_hand, i);
                ds_list_add(global.card_inventory, card);  // Return the card to the deck
            }
            ds_list_clear(global.current_hand);  // Clear the current hand
        }

        // Calculate how many more cards need to be drawn
        var cards_needed = global.hand_size - ds_list_size(global.current_hand);

        // Check if there are no cards left in the deck
        if (ds_list_size(global.card_inventory) == 0) {
            // If there are no cards left in the deck, and the hand is also empty, transition to rm_overworld
            if (ds_list_size(global.current_hand) == 0) {
                room_goto(rm_overworld);  // Transition to the overworld room
                return;  // Stop the function from proceeding further
            }
        }

        // Draw new cards (up to the needed amount)
        for (var i = 0; i < cards_needed; i++) {
            if (ds_list_size(global.card_inventory) > 0) {
                // Randomly select a card from the deck
                var index = irandom(ds_list_size(global.card_inventory) - 1);
                var card = ds_list_find_value(global.card_inventory, index);

                // Add card to the hand
                ds_list_add(global.current_hand, card);

                // Remove card from the deck
                ds_list_delete(global.card_inventory, index);

                // Create the card instance at the bottom of the screen
                var x_pos = room_width / 2;  // Adjust for center alignment
                var y_pos = room_height / 2;  // Position near the bottom

                // Create the card instance and set its data
                var card_instance = instance_create_layer(x_pos, y_pos, "GUI", obj_card);
                card_instance.card_name = card[? "name"];
                card_instance.card_desc = card[? "description"];
                card_instance.card_cost = card[? "cost"];
                card_instance.card_script = card[? "script"];
                card_instance.card_sprite = card[? "sprite"];
            }
        }
    }
}

scr_draw_cards()