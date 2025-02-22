///////////////
// OVERWORLD //
///////////////
if (room != rm_encounter){
	////////////////////////////////////////
	// CAN ENCOUNTER A MOB EVERY 10 STEPS //
	////////////////////////////////////////
	if (global.can_encounter == false){
		if (global.steps > 10){
			global.can_encounter = true;
			
		}
	}


	//////////////////////
	// CALCULATE A STEP //
	//////////////////////
	// Calculate the player's current tile coordinates
	var _current_tile_x = obj_player.x div 32;
	var _current_tile_y = obj_player.y div 32;

	// Check if the current tile is different from the previous tile
	if (_current_tile_x != _previous_tile_x || _current_tile_y != _previous_tile_y) {
	    // The player has changed tiles
		global.steps++;
		obj_player._flag_can_touch = true;
		audio_play_sound(snd_walking_grass,0,false);
		
		//trigger a critter every so often
		var _rand = irandom(100);
		if (_rand < 10){
			scr_spawn_critter();
		}
			
			
	    // You can add custom logic here for tile change, like triggering events or effects
	    // Update the previous tile position
	    _previous_tile_x = _current_tile_x;
	    _previous_tile_y = _current_tile_y;		
	}
}