//////////////////////////////////////////////////////////////////////
//					SCR_CARD_HEALTH_BERRY_TICK						//
//																	//
// > UNDO BUFF AFTER TIMER ELAPSED									//	
//////////////////////////////////////////////////////////////////////
function scr_card_plant_knowledge_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 3
	
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._creature_hp_current = floor(_target._creature_hp_current/1.1);	
		_target._creature_hp_max = floor(_target._creature_hp_max/1.1);	
		scr_create_combat_popup(_target,"Plant Knowledge wore off","Default",0,0);
		_counter._counter_delete_flag = true;		
	} 
}