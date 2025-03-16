//////////////////////////////////////////////////////////////////////
//							SCR_CARD_BLOCK							//
//																	//
// > CAST A SHIELD ON SELF											//
//////////////////////////////////////////////////////////////////////
function scr_card_block(_card,_channel,_target){
	/////////////
	// DEFENSE //
	/////////////
	var _ab_check = scr_check_armorbreak(_target);
	if (_ab_check == false){	
		_target._creature_def += 8;
		scr_create_combat_popup(_target,"+8","Shields",0,0);
	}
	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_shield,0,0,_card._card_animation_time,c_aqua,0.3,0.3,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");

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