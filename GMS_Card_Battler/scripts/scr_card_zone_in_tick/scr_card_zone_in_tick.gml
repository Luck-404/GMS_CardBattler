//////////////////////////////////////////////////////////////////////
//						SCR_CARD_ZONE_IN_TICK						//
//																	//
// > UNDO BUFF AFTER TIMER ELAPSED									//	
//////////////////////////////////////////////////////////////////////
function scr_card_zone_in_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 3
	
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._creature_attack_linear -= (4*_counter._counter_stacks);
		scr_create_combat_popup(_target,"Zone in wore off","Default",0,0);
		_counter._counter_delete_flag = true;		
	} 
}