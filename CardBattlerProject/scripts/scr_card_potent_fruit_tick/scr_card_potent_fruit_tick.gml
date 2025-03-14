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
		scr_create_combat_effect(_taret,spr_effect_potent_fruit_repeat,0,0);
	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._creature_attack_scalar = _target._creature_attack_scalar-1;	
		scr_create_combat_popup(_target,"Potent Fruit wore off","Default",0,0);
	} 
}