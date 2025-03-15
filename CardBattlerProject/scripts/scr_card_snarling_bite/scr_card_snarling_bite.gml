//////////////////////////////////////////////////////////////////////
//					SCR_CARD_SNARLING_BITE							//
//																	//
// > DEAL DAMAGE TO A SINGLE UNIT AT MELEE RANGE, APPLY VULN IF HP  //
//   IS HIT.														//
//////////////////////////////////////////////////////////////////////
function scr_card_snarling_bite(_card,_channel,_target){
	////////////////////////
	// SNAPSHOT TARGET HP //
	////////////////////////
	var _tar_hp = _target._creature_hp_current;
	
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0,0);
	
	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _calculated_dmg);
	scr_trigger_minion_reactions(_card,_target,_channel,_calculated_dmg);
		
	////////////////
	// VULNERABLE //
	////////////////
	if(_tar_hp != _target._creature_hp_current){
		audio_play_sound(snd_effect_debuff,0,false);	
		var _counter = scr_get_status_counter(_target, "General", undefined, "Vulnerablility Scalar");		
		if (_counter == undefined){		
			scr_create_status_counter(_target,"Vulnerablility Scalar","Increase damage taken by this unit by 50% per stack.",_card,"End",scr_status_vulnerable_scalar_tick, true, undefined, 1, 1, "+50% damage taken per stack", 0, "General", _target._creature_statuses, spr_status_vulnerability_up_scalar);
			_target._creature_vulnerability_scalar_stacks+=1;
			scr_create_combat_popup(_target,"Vulnerable applied","Default",0,0);			
		} 
		else {
			scr_create_combat_popup(_target,"+50% vulnerable","Default",0,0);			
			_counter._counter_life = 1;
			_counter._counter_stacks +=1;
			_target._creature_vulnerability_scalar_stacks+=1;
		}	
	}
	
	
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(_target,spr_effect_hit,0,0);
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_snarling_bite,0,false);	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));		
}