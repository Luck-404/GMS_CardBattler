///////////////////
// DRAWING CARDS //
///////////////////
// Default card dimensions
var _card_width = 80;
var _card_height = 120;
var _spacing = 150;  // Adjust this to control the spacing between cards

// Calculate the dynamic x_offset based on the number of cards in hand
var _var_hand_size = ds_list_size(global.current_hand);
var _x_offset = room_width / 2 - (_var_hand_size * _spacing) / 2;  // Center the cards dynamically

// Draw each card in the hand
for (var _i = 0; _i < _var_hand_size; _i++) {
    var _ref_card = ds_list_find_value(global.current_hand, _i);
    var _card_x_pos = _x_offset + _i * _spacing;  // Space the cards evenly across the bottom
    var _card_y_pos = room_height - _card_height - _spacing;

	/////////////
	// SCALING //
	/////////////
    // Default scaling to 25%
    var _scale = 0.20;


	//////////////////////////////////////////////
	// CHECKS FOR PLAYABILITY - GREYS CARDS OUT //
	//////////////////////////////////////////////
    // Check if the card can be played (check mana)
    var _flag_can_play = global.current_mana >= _ref_card[? "cost"];

    // If not enough mana, grey out the card and make it unselectable
    var _card_color = _flag_can_play ? c_white : c_gray;  // Grey out the card if not enough mana

	//////////////////////
	// MOUSE OVER CARDS //
	//////////////////////
    // Check if the mouse is over the card and the card is selectable
    if (point_in_rectangle(mouse_x, mouse_y, _card_x_pos - _card_width, _card_y_pos - _card_height, _card_x_pos + _card_width, _card_y_pos + _card_height) && _flag_can_play) {
        // Enlarge the card to 35% on hover
        _scale = 0.30;

		/////////////////////
		// SELECTION LOGIC //
		/////////////////////
        // If left-clicked, select the card, or unselect if it's already selected
        if (mouse_check_button_pressed(mb_left)) {
            // If a different card is selected, select the new one
            if (global.card_selected != _ref_card) {
                global.card_selected = _ref_card;  // Select the new card
            } else {
                global.card_selected = undefined;  // Unselect the card if it's already selected
            }
        }
    }

	////////////////////////////
	// KEEP SELECTED ENLARGED //
	////////////////////////////
    // If the card is selected, keep it enlarged at 35%
    if (global.card_selected == _ref_card) {
        _scale = 0.30;  // Full size for selected card
    }

    // Draw the card with the _scaled size and color adjustment
    draw_sprite_ext(_ref_card[? "sprite"], 0, _card_x_pos, _card_y_pos, _scale, _scale, 0, _card_color, 1);
    
			/////////////////////
			//  DRAW CARD NAME //
			/////////////////////	
		    // Draw the card name and description (optional)
		    draw_text(_card_x_pos, _card_y_pos - 30, _ref_card[? "name"]);
}


//////////////////////////////
// DRAW A LINE TO THE MOUSE //
//////////////////////////////
// If a card is selected, draw a line to the mouse
if (global.card_selected != undefined) {
    var _ref_selected_card = global.card_selected;
    var _ref_selected_card_index = -1;

    // Find the index of the selected card in the hand
    for (var _i = 0; _i < _var_hand_size; _i++) {
        if (ds_list_find_value(global.current_hand, _i) == _ref_selected_card) {
            _ref_selected_card_index = _i;
            break;
        }
    }

    // If found, calculate the position and draw a line to the mouse
    if (_ref_selected_card_index != -1) {
        var _selected__card_x_pos = _x_offset + _ref_selected_card_index * _spacing + _card_width/2;
        var _selected__card_y_pos = room_height - _card_height/2 - 150;

        draw_line_width(_selected__card_x_pos, _selected__card_y_pos, mouse_x, mouse_y, 3);
    }


			//////////////////////////
			// CHECK CORRECT TARGET //
			//////////////////////////


	///////////////////////////////////////
	// CLICK TO CONFIRM CAST W NO TARGET //
	///////////////////////////////////////
	if (global.card_selected != undefined) {
	    // Check if this card is "no target" and casting is not already in progress
	    if (_ref_selected_card[? "target"] == "None") {
	        if (!global.casting_phase) {
	            // On the first left click, enter the casting phase
	            if (mouse_check_button_pressed(mb_left)) {
	                global.casting_phase = true; // Enter casting phase
	            }
	        } else {
	            // On the second left click, confirm and play the card
	            if (mouse_check_button_pressed(mb_left)) {
	                var _ref_tar = undefined; // No specific target
	                scr_play_card(_ref_selected_card[? "script"], _ref_tar, _ref_selected_card[? "cost"]);

	                // Reset the casting phase and deselect the card
	                global.casting_phase = false;
	                global.card_selected = undefined;
	            }
	        }
	    }	
	}
	

	/////////////////////////////////////////////
	// HANDLE SPELLS WITH TARGET REQUIREMENTS //
	/////////////////////////////////////////////
	if (global.card_selected != undefined) {
	    // Check if the card requires a target
	    if (_ref_selected_card[? "target"] != "None") {
	        // If not already in the target selection phase
	        if (!global.casting_phase) {
	            // First click enters the casting phase
	            if (mouse_check_button_pressed(mb_left)) {
	                global.casting_phase = true; // Enter target selection phase
	            }
	        } else {
	            // During target selection phase, wait for a valid target
	            if (mouse_check_button_pressed(mb_left)) {
	                var _ref_tar = instance_position(mouse_x, mouse_y, obj_creature);

	                if (_ref_tar != noone) {
	                    // Play the card with the selected target
	                    scr_play_card(_ref_selected_card[? "script"], _ref_tar, _ref_selected_card[? "cost"]);

	                    // Reset the casting phase and deselect the card
	                    global.casting_phase = false;
	                    global.card_selected = undefined;
	                } else {
	                    // If the click does not hit a valid target, provide feedback
	                    show_debug_message("No valid target selected!");
	                }
	            }
	        }
	    }
	}
}

////////////////////////////
//  RIGHT CLICK UNSELECTS //
////////////////////////////
if (mouse_check_button_pressed(mb_right)) {
    global.card_selected = undefined;  // Unselect the card
    global.casting_phase = false;      // Reset casting phase
}


//////////////////////////////
// DEV TOOL - "D" TO REDRAW //
//////////////////////////////
// Handle drawing new cards when the D key is pressed
if (keyboard_check_pressed(ord("D")) && global.card_selected == undefined) {
    scr_draw_cards();  // Draw 3 new cards
}


///////////////////////
// DRAW HUD ELEMENTS //
///////////////////////
draw_text(100, 100, "Mana: " + string(global.current_mana) + "/" + string(global.max_mana));
draw_text(1620, 100, "Cards in hand: " + string(_var_hand_size));
draw_text(1620, 150, "Cards in deck: " + string(ds_list_size(global.card_inventory)));
draw_text(1620, 200, "Cards exhausted: " + string(ds_list_size(global.exhausted)));

if (global.card_selected != undefined) {
    draw_text(room_width/2-100, 400, "Card selected: " + string(global.card_selected[? "name"]));
}

if (global.casting_phase) {
    draw_text(room_width / 2, 300, "Click again to confirm casting!");
}