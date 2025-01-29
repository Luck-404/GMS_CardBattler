//if player is within 100px, run in a random direction x (xscale -1 or 1) and disappear after 2 seconds
if (distance_to_object(obj_player) < 100){
	_triggered = true;
}
if (_triggered){
	_life--;
	x += 3*_runx_direction;
	y += 2*_runy_direction;	
	image_xscale = -_runx_direction;
	if (_life <= 0){
		instance_destroy();
	}
}