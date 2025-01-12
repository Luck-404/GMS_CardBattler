// Step Event
if (is_fading) {
    // Increase alpha (fade in)
    image_alpha += fade_speed;
    
    // Check if fully opaque
    if (image_alpha >= 1) {
        image_alpha = 1;
        
        // Switch room
        if (target_room != -1) {
			global.steps = 0;
			global.can_encounter = false;
            room_goto(target_room);
			instance_destroy();
        }
    }
}