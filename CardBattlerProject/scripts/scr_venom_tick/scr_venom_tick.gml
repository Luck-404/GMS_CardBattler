//////////////////////////////////////////////////////////////////////
//							SCR_CARD_VENOM_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_venom_tick(_target,_repeat){
	if (_repeat == false){ //removal
		//fix debuff
		_target._creature_attack_linear = _target._creature_attack_linear+_target._venom_count;
		
		//clear venom
		_target._venom_count = 0;
		_target._venom_counter_ref = undefined;

	} 
	
	
	else { //damage scales with each stack
		var _stacks = _target._venom_count;
		_target._creature_hp_current -= abs(_target._creature_def-(3*_stacks));	
		_target._creature_def -= (3*_stacks);
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
	}
}
