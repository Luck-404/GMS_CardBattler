function scr_card_poison(_target,_repeat){
	if (_repeat == false){
		
	} else {
		var _stacks = _target._poison_count;
		_target._creature_hp_current -= abs(_target._creature_def-(6*_stacks));	
		_target._creature_def -= (6*_stacks);
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
	}
}
