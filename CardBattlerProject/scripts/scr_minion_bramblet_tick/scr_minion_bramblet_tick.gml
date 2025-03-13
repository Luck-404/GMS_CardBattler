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
	scr_create_combat_popup(_host,"5","Shields",0,0);
	scr_create_combat_popup(_self,"2","Shields",0,0);	

	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_host,spr_card_block,0,0);
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_block,0,false);	
}