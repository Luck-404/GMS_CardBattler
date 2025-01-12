// Default card dimensions
var card_width = 100;
var card_height = 150;
var spacing = 120;  // Adjust this to control the spacing between cards

// Calculate the dynamic x_offset based on the number of cards in hand
var hand_size = ds_list_size(global.current_hand);
var x_offset = room_width / 2 - (hand_size * spacing) / 2;  // Center the cards dynamically

// Draw each card in the hand
for (var i = 0; i < hand_size; i++) {
    var card = ds_list_find_value(global.current_hand, i);
    var card_x_pos = x_offset + i * spacing;  // Space the cards evenly across the bottom
    var card_y_pos = room_height - card_height - 10;

    // Default scaling to 25%
    var scale = 0.25;

    // Check if the card can be played (check mana)
    var can_play = global.current_mana >= card[? "cost"];

    // If not enough mana, grey out the card and make it unselectable
    var card_color = can_play ? c_white : c_gray;  // Grey out the card if not enough mana

    // Check if the mouse is over the card and the card is selectable
    if (point_in_rectangle(mouse_x, mouse_y, card_x_pos - card_width / 2, card_y_pos - card_height / 2, card_x_pos + card_width / 2, card_y_pos + card_height / 2) && can_play) {
        // Enlarge the card to 35% on hover
        scale = 0.35;

        // If left-clicked, select the card, or unselect if it's already selected
        if (mouse_check_button_pressed(mb_left)) {
            // If a different card is selected, select the new one
            if (global.card_selected != card) {
                global.card_selected = card;  // Select the new card
            } else {
                global.card_selected = undefined;  // Unselect the card if it's already selected
            }
        }
    }

    // If the card is selected, keep it enlarged at 35%
    if (global.card_selected == card) {
        scale = 0.35;  // Full size for selected card
    }

    // Draw the card with the scaled size and color adjustment
    draw_sprite_ext(card[? "sprite"], 0, card_x_pos, card_y_pos, scale, scale, 0, card_color, 1);
    
    // Draw the card name and description (optional)
    draw_text(card_x_pos, card_y_pos + card_height / 2 - 45, card[? "name"]);
}

// If a card is selected, draw a line to the mouse
if (global.card_selected != undefined) {
    var selected_card = global.card_selected;
    var selected_card_index = -1;

    // Find the index of the selected card in the hand
    for (var i = 0; i < hand_size; i++) {
        if (ds_list_find_value(global.current_hand, i) == selected_card) {
            selected_card_index = i;
            break;
        }
    }

    // If found, calculate the position and draw a line to the mouse
    if (selected_card_index != -1) {
        var selected_card_x_pos = x_offset + selected_card_index * spacing;
        var selected_card_y_pos = room_height - card_height - 10;

        draw_line_width(selected_card_x_pos, selected_card_y_pos, mouse_x, mouse_y, 2);
    }

    // Handle playing the card by clicking on a creature
    if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, obj_creature)) {
        var _tar = instance_position(mouse_x, mouse_y, obj_creature);
        scr_play_card(global.card_selected[? "script"], _tar, global.card_selected[? "cost"]);  // Call the attached card script
    }
}

// Unselect the card only if you right-click, or click anywhere else that isn't a card or obj_creature
if (mouse_check_button_pressed(mb_right)) {
    global.card_selected = undefined;  // Unselect the card
}

// Handle drawing new cards when the D key is pressed
if (keyboard_check_pressed(ord("D")) && global.card_selected == undefined) {
    scr_draw_cards();  // Draw 3 new cards
}

// Draw additional HUD elements
draw_text(100, 100, "Mana: " + string(global.current_mana) + "/" + string(global.max_mana));
draw_text(1620, 100, "Cards in hand: " + string(hand_size));
draw_text(1620, 150, "Cards in deck: " + string(ds_list_size(global.card_inventory)));
draw_text(1620, 200, "Cards exhausted: " + string(ds_list_size(global.exhausted)));

// Debugging helper print
if (global.card_selected != undefined) {
    draw_text(room_width/2-100, 400, "Card selected: " + string(global.card_selected[? "name"]));
}