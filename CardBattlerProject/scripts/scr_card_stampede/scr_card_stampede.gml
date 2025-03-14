//////////////////////////////////////////////////////////////////////
//							SCR_CARD_STAMPEDE						//
//																	//
// > DEAL DAMAGE TO ALL UNITS OF THE GIVEN TEAM						//	
//////////////////////////////////////////////////////////////////////
function scr_card_stampede(_card,_channel,_target){
	/////////////////
	// TEAM CHOICE //
	////////////////
	var _tars = undefined;
	if (_target._creature_team == "Player"){
		_tars = global.player_party_in_play;	
	}
	else {
		_tars = global.enemy_party_in_play;
	}
	
	////////////////////////////////
	// FOR EVERY UNIT IN THE TEAM //
	////////////////////////////////
	for (var _i = 0; _i < ds_list_size(_tars); _i++){
		var _unit = ds_list_find_value(_tars,_i);
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_unit,_card._card_ref[?"damage"]);

		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_unit, _calculated_dmg);
		scr_trigger_minion_reactions(_card,_unit,_channel,_calculated_dmg);
	
		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_unit,spr_effect_strike,0,0);
	}
		
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_stampede,0,false);		
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}