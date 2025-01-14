//////////////////////
// FADE IN AND OUT //
//////////////////////
if (_is_fading) {
    if (_is_fading_in) {
        // Increase alpha (fade in)
        image_alpha += _fade_speed;

        // Check if fully opaque
        if (image_alpha >= 1) {
            image_alpha = 1;

            // Start fading out after fade in is complete
            _is_fading_in = false;
            room_goto(_target_room);		
            _is_fading_out = true;
        }
    } else if (_is_fading_out) {
        // Decrease alpha (fade out)
        image_alpha -= _fade_speed;

        // Check if fully transparent
        if (image_alpha <= 0) {
            image_alpha = 0;

            // Transition to the target room and clean up
            if (_target_room != -1) {
                global.steps = 0;
                global.can_encounter = false;	
				obj_player.visible = false;
                instance_destroy();
            }
        }
    }
}
