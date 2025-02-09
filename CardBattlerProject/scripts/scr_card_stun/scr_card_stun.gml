function scr_card_stun(_target,_repeat){
	if (_repeat == false){
		
	} else {
		//prevent target from moving
		_target._turn_available = false;
	}
}