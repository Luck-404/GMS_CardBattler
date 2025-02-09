function scr_card_poison(_target,_repeat){
	if (_repeat == false){
		
	} else {
		//damage 4
		_target._creature_hp_current -= abs(_target._creature_def-4);	
		_target._creature_def -= 4;
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
	}
}