//////////////////////////////////////////////////////////////////////
//						SCR_CARD_HEALING_SALVE						//
//																	//
// > HEAL A UNIT FOR 5 HP											//	
//////////////////////////////////////////////////////////////////////
function scr_card_plant_knowledge(_card,_channel,_target){
	//////////
	// HEAL //
	//////////
	scr_heal_creature(_target,12,0);
	scr_trigger_global_reactions(_card,_target,_channel,0);
	
	//////////
	// BUFF //
	//////////
	var _counter = scr_get_status_counter(_target, "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter(_target,"Plant Knowledge","10% bonus hp for 10 turns.",_card,"End",scr_card_plant_knowledge_tick, true, undefined, 10, 0, "+10% hp", 0, "Standalone", _target._creature_statuses, spr_status_health_bonus);
		scr_create_combat_popup(_target,"+10% HP","Default",0,0);	
		_target._creature_hp_current = ceil(_target._creature_hp_current*1.1);
		_target._creature_hp_max = ceil(_target._creature_hp_max*1.1);	
	} 
	else {
		_counter._counter_life = 10;
	}		
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_heal,0,0,11,c_white,0.5,0.5,0,0,0,"Stationary",undefined,"Effects");
	scr_create_combat_effect(_target,spr_effect_powerup,0,0,36,c_green,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_heal,0,false);	
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