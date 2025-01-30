//if player is within 100px, run in a random direction x (xscale -1 or 1) and disappear after 2 seconds
if (distance_to_object(obj_player) < 100){
	_triggered = true;
}
if (_triggered){
	_life--;
	switch (image_index){
		case 0: //bird
		//sound
		
		//movement
		x += sin(2*_runy_direction * 1.0 + current_time/1000) * 0.02; 
		y += sin(3*_runx_direction * 1.0 + current_time/1000) * 0.02; 		
		break;
		
		case 1: //squirrel
		//sound
		
		//movement
		
		break;
		
		case 2: //frog
		//sound
		
		//movement
		
		break;
		
		case 3: //bugs
		//sound
		
		//movement
		
		break;		
	}

	image_xscale = -_runx_direction;
	if (_life <= 0){
		instance_destroy();
	}
}