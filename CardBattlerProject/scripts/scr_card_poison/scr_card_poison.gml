function scr_card_poison(_target,_repeat){
	if (_repeat == false){
		_target._poison_count = 0;
		_target._poison_counter_ref = undefined;
	} else {
		var _stacks = _target._poison_count;
		_target._creature_hp_current -= abs(_target._creature_def-(4*_stacks));	
		_target._creature_def -= (4*_stacks);
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
	}
}
