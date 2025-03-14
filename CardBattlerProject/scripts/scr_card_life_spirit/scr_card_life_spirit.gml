//////////////////////////////////////////////////////////////////////
//						SCR_CARD_LIFE_SPIRIT						//
//																	//
// > SUMMON A LIFE SPIRIT, WHICH HEALS THE HOST UNIT 5% HP PER TURN //
//////////////////////////////////////////////////////////////////////
function scr_card_life_spirit(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	scr_create_combat_minion(_card,_channel,_target,"Life Spirit");
	scr_trigger_minion_reactions(_card,_target,_channel,0);

	////////////
	// EFFECT //
	////////////
		//TODO COOL EFFECT - sparkle into exsitence
	
	///////////
	// SOUND //
	///////////
		//TODO
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}