//esc to end game
if (keyboard_check_pressed(vk_escape)){
	game_end();	
}

if (keyboard_check_pressed(ord("F"))){
	_flag_fullscreen = !_flag_fullscreen;
	window_set_fullscreen(_flag_fullscreen);
}

if (keyboard_check_pressed(ord("E")) && place_meeting(x,y,obj_sparkly)){
	instance_create_layer(x,y,"GUI",obj_card);
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
    var move_speed = 4; // Pixels per step
    if (x < target_x) x = min(x + move_speed, target_x);
    if (x > target_x) x = max(x - move_speed, target_x);
    if (y < target_y) y = min(y + move_speed, target_y);
    if (y > target_y) y = max(y - move_speed, target_y);

    // Stop moving when the target position is reached
    if (x == target_x && y == target_y) {
	    moving = false;
    }
}