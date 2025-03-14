//////////////////////////////////////////////////////////////////////
//						SCR_CARD_GROW_MANAVINE						//
//																	//
// > ADD 2 BONUS MANA FOR 3 TURNS									//	
//////////////////////////////////////////////////////////////////////
function scr_card_grow_manavine(_card,_channel,_target){
	////////////////
	// BONUS MANA //
	////////////////
	var _counter = scr_get_status_counter("Global Utility", "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter("Global Utility","Manavine","Gain 2 bonus mana per turn, lasts 3 turns",_card,"End",scr_card_grow_manavine_tick, true, undefined, 3, 0, "2 bonus mana", 0, "Standalone", global.encounter_statuses, spr_status_mana_bonus);
		scr_create_combat_popup(undefined,"+2 Bonus Mana","Default",room_width/2,room_height/2);
		scr_create_combat_popup(undefined,"","Mana",room_width/2,room_height/2);			
		//decrement bonus mana
		global.bonus_mana+=2;
		global.cur_mana+=2;	
	} 
	else {
		_counter._counter_life = 3;
	}
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_grow_manavine,room_width/2,room_height/2);
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_grow_manavine,0,false);		
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}