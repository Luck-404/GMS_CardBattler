//////////////////////////////////////////////////////////////////////
//						SCR_MINION_BRAMBLET_TICK					//
//																	//
// > ADD 5 DEF TO HOST												//	
//////////////////////////////////////////////////////////////////////
function scr_minion_bramblet_tick(_host,_self){
	/////////////////////////////
	// DEF UP ON UNIT AND SELF //
	/////////////////////////////
	_host._creature_def += 5; 
	_self._minion_def = 2;
	
	//////////////////
	// COMBAT POPUP //
	//////////////////
	scr_create_combat_popup(_host,"+5","Shields",0,0);
	scr_create_combat_popup(_self,"+2","Shields",0,0);	

	////////////
	// EFFECT //
	////////////
		//TODO
	
	///////////
	// SOUND //
	///////////
		audio_play_sound(snd_effect_shield,0,false);
		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("COMBAT: BRAMBLET ADDED ARMOR TO HOST");		
}