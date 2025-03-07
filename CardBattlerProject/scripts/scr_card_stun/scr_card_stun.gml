function scr_card_stun(_target,_repeat){
	if (_repeat == false){
		_target._stunned = false;
		
	} else {
		//prevent target from moving
		_target._stunned = true;
	}
}