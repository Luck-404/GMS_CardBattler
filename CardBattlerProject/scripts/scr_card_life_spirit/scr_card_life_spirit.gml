//////////////////////////////////////////////////////////////////////
//						SCR_CARD_LIFE_SPIRIT						//
//																	//
// > SUMMON A LIFE SPIRIT, WHICH HEALS THE HOST UNIT 5% HP PER TURN //
//////////////////////////////////////////////////////////////////////
function scr_card_life_spirit(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	var _new_minion = scr_create_combat_minion(_card,_channel,_target,"Life Spirit");
	scr_trigger_global_reactions(_card,_target,_channel,0);

	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_minion_poof,_target.x,_target.y+110,18,c_white,0.8,0.8,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_cast_life_spirit,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}