//////////////////////////////////////////////////////////////////////
//					SCR_CARD_INSPIRATION							//
//																	//
// > GAIN 1 BONUS MANA FOR 3 TURNS									//
//////////////////////////////////////////////////////////////////////
function scr_card_inspiration(_card,_channel,_target){
	////////////////
	// BONUS MANA //
	////////////////
	var _counter = scr_get_status_counter("Global Utility", "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter("Global Utility","Inspiration","Gain a bonus mana per turn, lasts 3 turns",_card,"End",scr_card_inspiration_tick, true, undefined, 3, 0, "1 bonus mana", 0, "Standalone", global.encounter_statuses, spr_status_mana_bonus);
		scr_create_combat_popup(undefined,"+1 Bonus Mana","Default",room_width/2,room_height/2);
		scr_create_combat_popup(undefined,"","Mana",room_width/2,room_height/2);			
		//decrement bonus mana
		global.bonus_mana++;
		global.cur_mana++;	
	} 
	else {
		_counter._counter_life = 3;
	}
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_inspiration,room_width/2,room_height/2);
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_inspiration,0,false);		
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}