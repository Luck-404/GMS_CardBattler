//////////////////////////////////////////////////////////////////////
//						SCR_CARD_BEASTIAL_BASH						//
//																	//
// > DEAL DAMAGE THREE UNITS, CENTER UNIT IS ALSO STUNS FOR 1 TURN  //	
//////////////////////////////////////////////////////////////////////
function scr_card_beastial_bash(_card,_channel,_target){
	/////////////////
	// LEFT TARGET //
	/////////////////
	if (_target._left_unit != undefined){
		var _left_target = _target._left_unit;
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0);
	
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_left_target, _calculated_dmg);
		scr_trigger_minion_reactions(_card,_left_target,_channel,_calculated_dmg);
		
		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_left_target,spr_effect_strike,0,0);

		///////////
		// DEBUG //
		///////////
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));
	}
		
	//////////////////
	// RIGHT TARGET //
	//////////////////
	if (_target._right_unit != undefined){
		var _right_target = _target._right_unit;
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0);
	
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_right_target, _calculated_dmg);
		scr_trigger_minion_reactions(_card,_right_target,_channel,_calculated_dmg);
		
		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_right_target,spr_effect_strike,0,0);

		///////////
		// DEBUG //
		///////////
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));
	}
	
	///////////////////
	// MIDDLE TARGET //
	///////////////////
	#region MIDDLE TARGET
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0);
	
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_target, _calculated_dmg);
		scr_trigger_minion_reactions(_card,_target,_channel,_calculated_dmg);
		
		//////////
		// STUN //
		//////////
		var _counter = scr_get_status_counter(_target,"General",undefined,"Stun");		
		if (_counter == undefined){		
			scr_create_status_counter(_target,"Stun","Target is stunned for 1 turn",_card,"End",scr_status_stun_tick, true, undefined, 1, 0, "Stun for 1 turn", 0, "General", _target._creature_statuses, spr_status_stun);
			scr_create_combat_popup(_target,"Stunned","Default",0,0);
			_target._status_stunned = true;			
		} 
		else {
			_counter._counter_life = 1;
		}
		
		////////////
		// EFFECT //
		////////////
		scr_create_combat_effect(_target,spr_effect_beastial_bash,0,0);

		///////////
		// SOUND //
		///////////
		audio_play_sound(snd_effect_beastial_bash,0,false);	
	#endregion
	

	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"]);

}