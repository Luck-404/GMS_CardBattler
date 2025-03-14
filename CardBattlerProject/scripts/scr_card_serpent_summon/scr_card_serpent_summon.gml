//////////////////////////////////////////////////////////////////////
//						SCR_CARD_SERPENT_SUMMON						//
//																	//
// > SUMMON 3 SERPENTS												//
//////////////////////////////////////////////////////////////////////
function scr_card_serpent_summon(_card,_channel,_target){
	/////////////////////
	// SPAWN 3 MINIONS //
	/////////////////////
	for(var _i = 0; _i < _target._creature_minion_limit; _i++){
		scr_create_combat_minion(_card,_channel,_target,"Serpent");
	}

	/////////////////////////////
	// GIVE 10 LINEAR DMG BUFF //
	/////////////////////////////
	#region BUFF
		/////////////////////////
		// CHECK EFFECT EXISTS //
		/////////////////////////
		var _counter = scr_get_status_counter(_target, "Standalone", _card._card_name, undefined);		
		if (_counter == undefined){		
			scr_create_status_counter(_target,"Serpent Tamer","Increase damage dealt by this unit 10",_card,"End",scr_card_serpent_summon_tick, true, scr_card_serpent_summon_check, 999, 0, "+10 damage", 0, "Standalone", _target._creature_statuses, spr_status_damage_up_linear);
			scr_create_combat_popup(_target,"+10 damage","Default",0,0);	
			_target._creature_attack_linear = _target._creature_attack_linear+10;
		} 
		else {
			_counter._counter_life = 999;
		}		
	#endregion
	
	scr_trigger_minion_reactions(_card,_target,_channel,0);	
		
		
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_potent_fruit,0,false);	
	
	////////////
	// EFFECT //
	////////////
		//TODO
		
		
		
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);		
}