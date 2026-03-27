//////////////////////////////////////////////////////////////////////
//						___________________							//
//																	//
// > __________________________________________						//
//////////////////////////////////////////////////////////////////////
function scr_card_clear_battlefield(_card,_channel,_target){
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}