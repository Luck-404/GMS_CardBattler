//
//
// STEP: OBJ_SIGN
//
//

//IF PLAYER IS NEXT TO, HIGHLIGHT IT
if (distance_to_object(obj_player) < 48){
	//ALLOW FOR TRIGGERING AN INTERACTION
	if (_flag_triggered == false && _cooldown == 0){
		image_index = 1;
		if (keyboard_check(ord("E"))){
			_flag_triggered = true;
			image_index = 0;
			scr_create_text_bubble(x,y-64,_sign_text);
			_cooldown = 60;
		}
	}
} else {
	image_index = 0;
}

if (_cooldown > 0){
	_cooldown--;	
	if (_cooldown <= 0){
		_cooldown = 0;
		_flag_triggered = false;	
	}
}


	