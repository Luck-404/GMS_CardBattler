//////////////////////////////////////////////////////////////////////
//							SCR_CARD_VENOM_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_venom_tick(_counter,_target,_repeat){ //EFFECTED BY STACKS //DEFAULT LIFETIME: 3	
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		_target._creature_hp_current -= abs(_target._creature_def-(3*(_counter._counter_stacks)));	
		_target._creature_def -= (3*(_counter._counter_stacks));
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
		scr_create_combat_popup(_target,string(3*_counter._counter_stacks),"Venom",0,0);
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._status_venom = false;		
		_target._creature_attack_linear = _target._creature_attack_linear+_counter._counter_stacks;
		scr_create_combat_popup(_target,"Venom cured","Venom",0,0);
	} 	
}
