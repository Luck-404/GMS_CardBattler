//////////////////////////////////////////////////////////////////////
//							SCR_CARD_FELL							//
//																	//
// > DEAL DAMAGE TO ONE UNIT AT MELEE								//	
//////////////////////////////////////////////////////////////////////
function scr_card_fell(_card,_channel,_target){
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,_card._card_ref[?"damage"],0);

	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _calculated_dmg);
	scr_trigger_global_reactions(_card,_target,_channel,_calculated_dmg);
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_slice,0,0,_card._card_animation_time,c_white,0.25,0.25,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_fell,0,false);	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));

}