//////////////////////
// INCREASE OPACITY //
//////////////////////
if (_is_fading) {
    // Increase alpha (fade in)
    image_alpha += _fade_speed;
    
    // Check if fully opaque
    if (image_alpha >= 1) {
        image_alpha = 1;
        
        ////////////////
		// TRANSITION //
		////////////////
        if (_target_room != -1) {
			global.steps = 0;
			global.can_encounter = false;
            room_goto(_target_room);
			instance_destroy();
        }
    }
}