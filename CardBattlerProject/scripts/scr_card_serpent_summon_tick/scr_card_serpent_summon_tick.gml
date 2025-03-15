//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SERPENT_SUMMON_TICK					//
//																	//
// > REMOVE 10DMG BUFF												//	
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon_tick(_counter,_target,_repeat){	//STACKLESS	//DEFAULT LIFETIME: 999
	////////////////////
	// TRIGGER EFFECT //
	////////////////////
	if (_repeat == true){

	}
	
	/////////////////
	// UNDO EFFECT //
	/////////////////	
	else {
		_target._creature_attack_linear = _target._creature_attack_linear-10;
		scr_create_combat_popup(_target,"Serpent Tamer wore off","Default",0,0);
		_counter._counter_delete_flag = true;		
	} 	
}