//////////////////////////////////////////////////////////////////////
//					SCR_MINION_LIFE_SPIRIT_TICK						//
//																	//
// > HEAL A UNIT FOR 20% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_minion_life_spirit_tick(_host,_self){
	///////////////
	// HEAL HOST //
	///////////////
	scr_heal_creature(_host,0,0.08);
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_host,spr_effect_heal,0,0,44,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_heal,0,false);
		
		
		
	///////////
	// DEBUG //
	///////////		
	show_debug_message("COMBAT: LIFE SPIRIT HEAlED HOST");
}