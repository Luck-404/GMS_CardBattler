//esc to end game
if (keyboard_check_pressed(vk_escape)){
	game_end();	
}

if (keyboard_check_pressed(ord("F"))){
	_flag_fullscreen = !_flag_fullscreen;
	window_set_fullscreen(_flag_fullscreen);
}

if (room == rm_overworld){
	visible = true;
	if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_sparkly)){
		var rand = choose("echo","inspire","block","strike","bulwark","power");
		switch(rand){
			//0 cost
			case "echo":
				var card_echo = scr_create_card("Echo", "Next spell cast twice, exhaust", 0, scr_card_echo, spr_card_echo);
				ds_list_add(global.card_inventory, card_echo);
			break;
		
			case "inspire":
				var card_inspiration = scr_create_card("Inspiration", "Gain 1 mana, exhaust", 0, scr_card_inspiration, spr_card_insirpation);
				ds_list_add(global.card_inventory, card_inspiration);
			break;
		
			//1 cost
			case "block":
				var card_block = scr_create_card("Block", "Defend 5", 1, scr_card_block, spr_card_block);
				ds_list_add(global.card_inventory, card_block);
			break;
		
			case "strike":
				var card_strike = scr_create_card("Strike", "Attack 6", 1, scr_card_strike, spr_card_strike);
				ds_list_add(global.card_inventory, card_strike);
			break;
		
			//2 cost
			case "bulwark":
				var card_bulwark = scr_create_card("Bulwark", "Defend 10", 2, scr_card_bulwark, spr_card_bulwark);
				ds_list_add(global.card_inventory, card_bulwark);
			break;
		
			case "power":
				var card_power_strike = scr_create_card("Power Strike", "Attack 12", 2, scr_card_power_strike, spr_card_power_strike);
				ds_list_add(global.card_inventory, card_power_strike);
			break;
		}
	}


	// Define a delay between tile moves
	if (!moving) {
	        // Get tile layer and current tile at the target position
	        var tile_layer = layer_tilemap_get_id("ts_overworld"); // Replace with your tile layer name
	        var next_x = x, next_y = y;

	        // Check input for movement using WASD keys
	        if (keyboard_check(ord("A"))) { // Move left
	            next_x = x - 32;
	            image_xscale = -1; // Flip sprite to face left
	        } else if (keyboard_check(ord("D"))) { // Move right
	            next_x = x + 32;
	            image_xscale = 1; // Face sprite to the right
	        } else if (keyboard_check(ord("W"))) { // Move up
	            next_y = y - 32;
	        } else if (keyboard_check(ord("S"))) { // Move down
	            next_y = y + 32;
	        }

	        // Check if a tile exists at the target position
	        if (tilemap_get_at_pixel(tile_layer, next_x, next_y) != 0) {
	            target_x = next_x;
	            target_y = next_y;
	            moving = true; // Start moving
	        }
	}

	// Smooth movement to the target position
	if (moving) {
	    if (x < target_x) x = min(x + _move_speed, target_x);
	    if (x > target_x) x = max(x - _move_speed, target_x);
	    if (y < target_y) y = min(y + _move_speed, target_y);
	    if (y > target_y) y = max(y - _move_speed, target_y);

	    // Stop moving when the target position is reached
	    if (x == target_x && y == target_y) {
		    moving = false;
	    }
	}
}

if (room == rm_encounter){
	visible = false;
	if (_flag_deck_created == false){
		instance_create_layer(x,y,"GUI",obj_deck_handler);
		show_debug_message("CREATED DECK HANDLER");
		_flag_deck_created = true;
	}
}