//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POISON_IVY_TICK						//
//																	//
// > TICK DAMAGE EACH TURN ON THE UNIT, RESET COUNT IF IT RUNS OUT  //	
//////////////////////////////////////////////////////////////////////
function scr_status_poison_tick(_counter,_target,_repeat){ 	//EFFECTED BY STACKS 	//DEFAULT LIFETIME: 3
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		_target._creature_hp_current -= abs(_target._creature_def-(3+(_counter._counter_stacks)));	
		_target._creature_def -= (3+(_counter._counter_stacks));
		if (_target._creature_def <= 0){
			_target._creature_def = 0;
		}
		scr_create_combat_popup(_target,string(3+_counter._counter_stacks),"Poison",0,0);
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._status_poisoned = false;		
		scr_create_combat_popup(_target,"Poison cured","Poison",0,0);
	} 
}
