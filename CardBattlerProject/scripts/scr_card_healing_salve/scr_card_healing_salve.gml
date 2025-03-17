//////////////////////////////////////////////////////////////////////
//						SCR_CARD_HEALING_SALVE						//
//																	//
// > HEAL A UNIT FOR 5 HP											//	
//////////////////////////////////////////////////////////////////////
function scr_card_healing_salve(_card,_channel,_target){
	//////////
	// HEAL //
	//////////
	scr_heal_creature(_target,5,0);
	scr_trigger_global_reactions(_card,_target,_channel,0);
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_heal,0,0,11,c_white,0.5,0.5,0,0,0,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_heal,0,false);	
	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}