//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BLOODBEAK						//
//																	//
// > SUMMON A BLOODBEAK MINION ON A UNIT							//
//////////////////////////////////////////////////////////////////////
function scr_card_bloodbeak(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	scr_create_combat_minion(_card,_channel,_target,"Bloodbeak");
	scr_trigger_minion_reactions(_card,_target,_channel,0);

	////////////
	// EFFECT //
	////////////
		//TODO COOL EFFECT - sparkle into exsitence
	
	///////////
	// SOUND //
	///////////
		audio_play_sound(snd_effect_cast_bloodbeak,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}