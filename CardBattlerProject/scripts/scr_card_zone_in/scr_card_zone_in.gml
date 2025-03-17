//////////////////////////////////////////////////////////////////////
//						SCR_CARD_ZONE_IN							//
//																	//
// > BUFF SELF +4									                //	
//////////////////////////////////////////////////////////////////////
function scr_card_zone_in(_card,_channel,_target){
	//////////////////
	// BONUS DAMAGE //
	//////////////////
	var _counter = scr_get_status_counter(_target, "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter(_target,"Zone In","Increase the next attack by 4dmg",_card,"End",scr_card_zone_in_tick, true, scr_card_zone_in_check, 999, 1, "+4 dmg for next attack", 1, "Standalone", _target._creature_statuses, spr_status_damage_up_linear);
		scr_create_combat_popup(_target,"+4 dmg","Default",0,0);	
		_target._creature_attack_linear += 4;
	} 
	else {
		_target._creature_attack_linear += 4;
		_counter._counter_stacks += 1;
		_counter._counter_life = 999;
	}	
	
	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_powerup,0,0,12,c_maroon,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_powerup,0,false);		
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}