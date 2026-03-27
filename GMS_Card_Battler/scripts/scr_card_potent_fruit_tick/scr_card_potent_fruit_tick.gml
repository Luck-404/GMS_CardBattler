//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POTENT_FRUIT_TICK						//
//																	//
// > UNDO BUFF AFTER TIMER ELAPSED									//	
//////////////////////////////////////////////////////////////////////
function scr_card_potent_fruit_tick(_counter,_target,_repeat){		//STACKLESS		//DEFAULT LIFETIME: 3
	
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){
		
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._creature_attack_scalar = _target._creature_attack_scalar-1;	
		scr_create_combat_popup(_target,"Potent Fruit wore off","Default",0,0);
		_counter._counter_delete_flag = true;		
	} 
}