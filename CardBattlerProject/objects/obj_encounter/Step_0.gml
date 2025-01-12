//check for encounter reset
if (global.can_encounter == false){
	if (global.steps > 10){
		global.can_encounter = true;
		global.steps = 0;
	}
}

// Calculate the player's current tile coordinates
var current_tile_x = obj_player.x div 32;
var current_tile_y = obj_player.y div 32;

// Check if the current tile is different from the previous tile
if (current_tile_x != previous_tile_x || current_tile_y != previous_tile_y) {
    // The player has changed tiles
	global.steps++;
    // You can add custom logic here for tile change, like triggering events or effects
    
    // Update the previous tile position
    previous_tile_x = current_tile_x;
    previous_tile_y = current_tile_y;
}