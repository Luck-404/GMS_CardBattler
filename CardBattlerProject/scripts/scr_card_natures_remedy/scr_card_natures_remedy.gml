//////////////////////////////////////////////////////////////////////
//						SCR_CARD_NATURES_REMEDY						//
//																	//
// > HEAL A UNIT FOR 33% MAX HP										//	
//////////////////////////////////////////////////////////////////////
function scr_card_natures_remedy(_card,_channel,_target){
	//////////
	// HEAL //
	//////////
	scr_heal_creature(_target,0,0.33);
	scr_trigger_global_reactions(_card,_target,_channel,0);
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_big_heal,0,0,_card._card_animation_time,c_white,0.3,0.3,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_big_heal,0,false);	
	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);	
}