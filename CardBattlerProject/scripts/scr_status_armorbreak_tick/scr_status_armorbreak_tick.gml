//////////////////////////////////////////////////////////////////////
//						SCR_STATUS_ARMORBREAK_TICK					//
//																	//
// > TICK EACH TURN													//
//////////////////////////////////////////////////////////////////////
function scr_status_armorbreak_tick(_counter,_target,_repeat){ 	//STACKLESS 	//DEFAULT LIFETIME: 2
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {	
		scr_create_combat_popup(_target,"Armorbreak wore off","Default",0,0);
		_target._status_armorbreak = false;		
		_counter._counter_delete_flag = true;				
	} 
}
