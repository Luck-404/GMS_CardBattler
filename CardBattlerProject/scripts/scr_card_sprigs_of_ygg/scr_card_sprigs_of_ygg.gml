//////////////////////////////////////////////////////////////////////
//						SCR_CARD_SPRIGS_OF_YGG						//
//																	//
// > SUMMON A SPRIGGAN IN EACH OPEN SPOT, SET UP COUNTER			//
//////////////////////////////////////////////////////////////////////
function scr_card_sprigs_of_ygg(_card,_channel,_target){
	/////////////
	// COUNTER //
	/////////////
	var _counter = scr_get_status_counter("Targetless", "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter("Targetless","Sprigs of Ygg","Spawn spriggans in every open slot, increase stacks on existing spriggans",_card,"Begin",scr_card_sprigs_of_ygg_tick, true, undefined, 5, 0, "1 trigger per turn", 0, "Standalone", global.encounter_statuses, spr_status_general_icon);
	} 
	else {
		_counter._counter_life = 5;
	}
	
	scr_trigger_global_reactions(_card,_target,_channel,0);	

	///////////
	// SOUND //
	///////////
		audio_play_sound(snd_effect_grow_plant,0,false);	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}