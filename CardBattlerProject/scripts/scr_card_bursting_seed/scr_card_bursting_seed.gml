//////////////////////////////////////////////////////////////////////
//						SCR_CARD_BURSTING_SEED						//
//																	//
// > DESTROY TARGET ARMOR, APPLY ARMORBREAK, APPLY VULNERABLE		//	
//////////////////////////////////////////////////////////////////////
function scr_card_bursting_seed(_card,_channel,_target){
	///////////
	// BURST //
	///////////
	if (_target._creature_def != 0){
		_target._creature_def = 0;
		audio_play_sound(snd_effect_break_shield,0,false);			
		scr_create_combat_effect(undefined,spr_def_break,_target.x+52,_target.y-90,7,c_white,1,1,0,0,0,"Stationary",undefined,"Effects");
	}
	
	////////////////////////
	// ARMORBREAK COUNTER //
	////////////////////////
	var _counter = scr_get_status_counter(_target,"General",undefined,"Poison");		
	if (_counter == undefined){		
		scr_create_status_counter(_target,"Armorbreak","Target cannot have armor",_card,"End",scr_status_armorbreak_tick, false, undefined, 2, 0, "Infinite", 0, "General", _target._creature_statuses, spr_status_antiarmor);
		scr_create_combat_popup(_target,"Armorbreak applied","Default",0,0);	
		_target._status_armorbreak = true;		
	} 
	else {
		_counter._counter_life = 2;
	}
	
	///////////////////
	// VULNERABILITY //
	///////////////////
	var _counter2 = scr_get_status_counter(_target, "General", undefined, "Vulnerablility Scalar");		
	if (_counter2 == undefined){		
		scr_create_status_counter(_target,"Vulnerablility Scalar","Increase damage taken by this unit by 50% per stack.",_card,"End",scr_status_vulnerable_scalar_tick, true, undefined, 1, 1, "+50% damage taken per stack", 0, "General", _target._creature_statuses, spr_status_vulnerability_up_scalar);
		_target._creature_vulnerability_scalar_stacks+=1;
		scr_create_combat_popup(_target,"Vulnerable applied","Default",0,0);		
		scr_create_combat_effect(_target,spr_effect_powerdown,0,0,36,c_purple,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");		
		audio_play_sound(snd_effect_debuff,0,false);	
	} 
	else {
		scr_create_combat_popup(_target,"+50% vulnerable","Default",0,0);			
		_counter2._counter_life = 1;
		_counter2._counter_stacks +=1;
		_target._creature_vulnerability_scalar_stacks+=1;
	}	
	
	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_powerup,0,0,36,c_green,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	
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