//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BRAMBLET						//
//																	//
// > SUMMON A BRAMBLET MINION ON SUMMONER							//
//////////////////////////////////////////////////////////////////////
function scr_card_bramblet(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	scr_create_combat_minion(_card,_channel,_target,"Bramblet");
	scr_trigger_global_reactions(_card,_target,_channel,0);

	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_minion_poof,_target.x,_target.y+110,18,c_white,0.8,0.8,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
		audio_play_sound(snd_effect_cast_bramblet,0,false);
		
		
		
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);				
}