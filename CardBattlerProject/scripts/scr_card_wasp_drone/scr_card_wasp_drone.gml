//////////////////////////////////////////////////////////////////////
//						SCR_CARD_LIFE_SPIRIT						//
//																	//
// > SUMMON A LIFE SPIRIT, WHICH HEALS THE HOST UNIT 5% HP PER TURN //
//////////////////////////////////////////////////////////////////////
function scr_card_wasp_drone(_card,_channel,_target){
	//////////////////
	// SPAWN MINION //
	//////////////////
	var _new_minion = scr_create_combat_minion(_card,_channel,_target,"Wasp Drone",[""]);
	scr_trigger_global_reactions(_card,_target,_channel,0);

	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_minion_poof,_target.x,_target.y+110,18,c_white,0.8,0.8,0,0,0,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_cast_wasp_drone,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}