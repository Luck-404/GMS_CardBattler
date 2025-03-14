//////////////////////////////////////////////////////////////////////
//				SCR_STATUS_VULNERABLE_SCALAR_TICK					//
//																	//
// > TICK EACH TURN													//
//////////////////////////////////////////////////////////////////////
function scr_status_vulnerable_scalar_tick(_counter,_target,_repeat){ 	//EFFECTED BY STACKS 	//DEFAULT LIFETIME: 1
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {	
		_counter._stacks +=1;
		_target._creature_vulnerability_scalar_stacks+=1;
		scr_create_combat_popup(_target,"Vulnerable wore off","Default",0,0);
	} 
}
