//////////////////////////////////////////////////////////////////////
//						SCR_MINION_BRAMBLET_TICK					//
//																	//
// > ADD 5 DEF TO HOST												//	
//////////////////////////////////////////////////////////////////////
function scr_minion_bramblet_tick(_host,_self){
	/////////////////////////////
	// DEF UP ON UNIT AND SELF //
	/////////////////////////////
	var _ab_check = scr_check_armorbreak(_target);
	if (_ab_check == false){
			_host._creature_def += 5; 
		scr_create_combat_popup(_host,"+5","Shields",0,0);
	}	
	
	_self._minion_def = 2;
	scr_create_combat_popup(_self,"+2","Shields",0,0);	





	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_host,spr_effect_shield,0,0,15,c_green,0.3,0.3,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
		audio_play_sound(snd_effect_shield,0,false);
		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("COMBAT: BRAMBLET ADDED ARMOR TO HOST");		
}