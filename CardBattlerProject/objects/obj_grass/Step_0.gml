////////////////
// DEACTIVATE //
////////////////
// Deactivate grass instance if far from the player
if (distance_to_object(obj_player) > _deactivation_range) {
    instance_deactivate_object(self);
    return; // Skip further processing
} else {
    instance_activate_object(self);
}


if (place_meeting(x, y, obj_player)) {
	if (global.can_encounter == true){
		var _rand = irandom_range(1,100);
		if (_rand <= 50 && _flag_transition_start == false){
			_flag_transition_start = true;	
			show_debug_message("=?= OBJ_GRASS: PLAYER HAS ENTERED GRASS AND TRIGGERED AN ENCOUNTER =?=");			
			show_debug_message("=?= OBJ_GRASS: SAVING PLAYER'S POSITION =?=");			
			global.player_xpos = obj_player.x;
			global.player_ypos = obj_player.y;
			show_debug_message("=?= OBJ_GRASS: SETTING PLAYER'S SPEED TO 0 =?=");		
			obj_player._move_speed = 0;			
			show_debug_message("=?= OBJ_GRASS: SENDING TO ENCOUNTER! =?=");			
			scr_start_transition(rm_encounter);
		}
	}
}

////////////////
// ACTIVATION //
////////////////
// Optimize by skipping checks if grass is not active
if (!_active) {
    // Handle dormant phase and reset
    if (_reset_delay > 0) {
        _reset_delay--; // Countdown the reset timer
    } else {
        _active = true; // Reactivate the grass
    }
    return; // Skip further checks
}

/////////////
// TRIGGER //
/////////////
// Check if the player is touching the grass and it's not already triggered
if (place_meeting(x, y, obj_player)) {
    if (!_touched) {
        _touched = true;   // Mark grass as touched
        image_speed = 10;  // Start the shaking animation
        spawn_leaves();    // Call function to spawn leaves
    }
} else {
    if (_touched) {
        // Reset state when player leaves
        _touched = false;     // Allow grass to trigger again next time
        _active = false;      // Deactivate grass
        _reset_delay = _reset_time; // Set reset delay timer
        image_speed = 0;      // Stop animation
        image_index = 0;      // Reset animation frame
    }
}