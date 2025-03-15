//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BLOCK							//
//																	//
// > CAST A SHIELD ON SELF											//
//////////////////////////////////////////////////////////////////////
function scr_card_block(_card,_channel,_target){
	/////////////
	// DEFENSE //
	/////////////
	_target._creature_def += 8;
	scr_create_combat_popup(_target,"+8","Shields",0,0);
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_block,0,0)	

	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_shield,0,false);
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}