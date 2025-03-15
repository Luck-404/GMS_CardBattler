//////////////////////////////////////////////////////////////////////
//					SCR_CARD_POWER_STRIKE							//
//																	//
// > DEAL DAMAGE TO A SINGLE UNIT AT MELEE RANGE					//
//////////////////////////////////////////////////////////////////////
function scr_card_power_strike(_card,_channel,_target){
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0,0);
	
	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _calculated_dmg);
	scr_trigger_minion_reactions(_card,_target,_channel,_calculated_dmg);
		
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_big_hit,0,0);
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_big_hit,0,false);	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));		
}