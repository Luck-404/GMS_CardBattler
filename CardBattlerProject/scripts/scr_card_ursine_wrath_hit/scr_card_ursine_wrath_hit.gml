//////////////////////////////////////////////////////////////////////
//					SCR_CARD_URSINE_WRATH_HIT						//
//																	//
// > CALLED FROM URSINE WRATH CARD, PLAYS ITSELF 3 TIMES ON TARGET	//
//////////////////////////////////////////////////////////////////////
function scr_card_ursine_wrath_hit(_card,_channel,_target){
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0,0);
	
	////////////////////////////////////////////////////////
	// ADD 1 MORE DAMAGE FOR EVERY 5 SHIELD CHANNELER HAS //
	////////////////////////////////////////////////////////
	var _additional_dmg = floor(_channel._creature_def/5);
	
	_calculated_dmg+=_additional_dmg;
	
	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _calculated_dmg);
	scr_trigger_minion_reactions(_card,_target,_channel,_calculated_dmg);
		
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_hit,0,0);
		//TODO
		
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_hit,0,false);	
}