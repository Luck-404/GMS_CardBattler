//////////////////////////////////////////////////////////////////////
//							SCR_CARD_ECHO							//
//																	//
// > INCREASE ECHO COUNT BY 1										//
//////////////////////////////////////////////////////////////////////
function scr_card_echo(_card,_channel,_target){
	global.echo_count += 1;	
	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_popup(undefined,"Echo count increased","Default",room_width/2,room_height/2);	
	scr_create_combat_effect(undefined,spr_effect_echo,room_width/2,room_height/2,_card._card_animation_time,c_white,1,1,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_echo,0,false);
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}
