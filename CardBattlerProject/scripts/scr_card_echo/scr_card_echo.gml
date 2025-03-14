//////////////////////////////////////////////////////////////////////
//							SCR_CARD_ECHO							//
//																	//
// > INCREASE ECHO COUNT BY 1										//
//////////////////////////////////////////////////////////////////////
function scr_card_echo(_card,_channel,_target){
	global.echo_count += 1;	
	scr_create_combat_popup(undefined,"Echo count increased","Default",room_width/2,room_height/2);
	scr_trigger_minion_reactions(_card,_target,_channel,0);	

	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}
