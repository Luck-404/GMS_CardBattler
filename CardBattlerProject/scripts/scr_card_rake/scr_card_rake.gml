//////////////////////////////////////////////////////////////////////
//						SCR_CARD_rake								//
//																	//
// > bleed melee target												//	
//////////////////////////////////////////////////////////////////////
function scr_card_rake(_card,_channel,_target){

	///////////
	// BLEED //
	///////////
	if (_target._creature_def == 0){
		var _counter = scr_get_status_counter(_target,"General",undefined,"Bleed");		
		if (_counter == undefined){		
			scr_create_status_counter(_target,"Bleed","Target is bleeding for 5 turns.",_card,"End",scr_status_bleed_tick, false, undefined, 5, 1, "2*(stacks)", 0, "General", _target._creature_statuses, spr_status_bleed);
			_target._status_bleeding = true;
		} 
		else {
			_counter._counter_life = 5;
			_counter._counter_stacks += 1;
		}
	////////////
	// EFFECT //
	////////////		
	scr_create_combat_popup(_target,"Bleeding","Damage",0,0);
	scr_create_combat_effect(_target,spr_effect_slice,0,0,5,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	scr_create_combat_effect(_target,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_slice,0,false);		
	} else {
		scr_create_combat_popup(_target,"Shield blocked bleed","Default",0,0);
	}

	scr_trigger_global_reactions(_card,_target,_channel,0);	
		

		
		
		
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _target._creature_name);		
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}