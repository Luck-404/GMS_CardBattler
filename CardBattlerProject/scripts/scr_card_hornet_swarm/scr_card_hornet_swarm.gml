//////////////////////////////////////////////////////////////////////
//						scr_card_hornet_swarm						//
//																	//
// > xxxxxxxxxxxxxxx  //	
//////////////////////////////////////////////////////////////////////
function scr_card_hornet_swarm(_card,_channel,_target){
	//////////
	// STUN //
	//////////
	var _counter = scr_get_status_counter(_target,"General",undefined,"Stun");		
	if (_counter == undefined){		
		audio_play_sound(snd_effect_stun,0,false);
		scr_create_status_counter(_target,"Stun","Target is stunned for 1 turn",_card,"End",scr_status_stun_tick, true, undefined, 1, 0, "Stun for 1 turn", 0, "General", _target._creature_statuses, spr_status_stun);
		scr_create_combat_popup(_target,"Stunned","Default",0,0);
		_target._status_stunned = true;			
	} 
	else {
		_counter._counter_life = 1;
	}
	scr_trigger_global_reactions(_card,_target,_channel,0);
		
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_powerdown,0,0,36,c_orange,0.25,0.25,undefined,undefined,undefined,undefined,undefined,"Stationary",undefined,"Effects");

	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_hornet_swarm,0,false);	
	

	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

}