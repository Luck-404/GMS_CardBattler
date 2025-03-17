//////////////////////////////////////////////////////////////////////
//						SCR_CARD_POTENT_FRUIT						//
//																	//
// > BUFF SELF TO DEAL 2X DAMAGE FOR 3 TURNS						//	
//////////////////////////////////////////////////////////////////////
function scr_card_potent_fruit(_card,_channel,_target){
	//////////////////
	// BONUS DAMAGE //
	//////////////////
	var _counter = scr_get_status_counter(_target, "Standalone", _card._card_name, undefined);		
	if (_counter == undefined){		
		scr_create_status_counter(_target,"Potent Fruit","Increase damage dealt by this unit by 2x, lasts 3 turns.",_card,"End",scr_card_potent_fruit_tick, true, undefined, 3, 0, "x2 damage", 0, "Standalone", _target._creature_statuses, spr_status_damage_up_scalar);
		scr_create_combat_popup(_target,"x2 Damage Scalar","Default",0,0);	
		_target._creature_attack_scalar = _target._creature_attack_scalar+1;
	} 
	else {
		_counter._counter_life = 3;
	}	
	
	scr_trigger_global_reactions(_card,_target,_channel,0);	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_powerup,0,0,36,c_maroon,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	
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