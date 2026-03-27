//////////////////////////////////////////////////////////////////////
//						SCR_CARD_RAKE								//
//																	//
// > double all dots												//	
//////////////////////////////////////////////////////////////////////
function scr_card_viral_shot(_card,_channel,_target){

	for (var _i = 0; _i < ds_list_size(_target._creature_statuses); _i++){
		var _counter = ds_list_find_value(_target._creature_statuses,_i);
		if (_counter._counter_type == "General"){
			_counter._counter_stacks = _counter._counter_stacks * 2;
			
			
		}
	}

	scr_trigger_global_reactions(_card,_target,_channel,0);	
		
	////////////
	// EFFECT //
	////////////		
	scr_create_combat_popup(_target,"DoTs Doubled","Default",0,0);
	scr_create_combat_effect(_target,spr_effect_powerdown,0,0,36,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _target._creature_name);		
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_blowdart,0,false);	
	audio_play_sound(snd_effect_debuff,0,false);	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}