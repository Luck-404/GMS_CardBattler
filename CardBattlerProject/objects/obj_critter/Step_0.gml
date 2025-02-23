if (distance_to_object(obj_player) > 800){
	instance_destroy();	
}
//if player is within 100px, run in a random direction x (xscale -1 or 1) and disappear after 2 seconds
if (distance_to_object(obj_player) < 100){
	_triggered = true;
}
if (_triggered){
	_life--;
	switch (image_index){
		case 0: // Bird
		    // Play flapping sound here
			audio_play_sound(snd_bird_startle,1,false);
		    x += sin(2 * _runy_direction * 1.0 + current_time / 300) * 1.5;
		    y -= 1.5 + random(0.5); // Move upwards erratically
		break;
		
		case 1: // Squirrel
		    // Play scurrying sound here
			//TODO
		    if (_life mod 10 == 0) _runx_direction *= -1; // Change direction randomly
		    x += _runx_direction * (2 + random(1)); // Move quickly left/right
		    y += sin(current_time / 200) * 1; // Minor jitter for effect
	    break;
		
		case 2: // Frog
		    // Play ribbit sound here
			//TODO
		    if (_life mod 15 == 0) { // Jump every 15 frames
		        x += _runx_direction * 3; // Jump horizontally
		        y -= 10; // Small upward jump
		    } else {
		        y += 2; // Gradually fall down after jump
		    }
		break;
		
		case 3: // Bugs
		    // Play buzzing sound here
			//TODO
		    x += choose(-1, 1) * random(2); // Random horizontal movement
		    y += choose(-1, 1) * random(2); // Random vertical movement
	    break;		
	}

	image_xscale = -_runx_direction;
	if (_life <= 0){
		instance_destroy();
	}
}