//////////////////////////////////////////////////////////////////////
//							scr_card_verdant_bolt					//
//																	//
// > DEAL DAMAGE TO A SINGLE UNIT AT RANGE							//
//////////////////////////////////////////////////////////////////////
function scr_card_verdant_bolt(_card,_channel,_target){
	var _tar_snapshot = _target._creature_hp_current;
	
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _calculated_dmg = scr_damage_calculator(_card,_channel,_target,0,0);
	
	////////////
	// DAMAGE //
	////////////
	scr_damage_creature(_target, _calculated_dmg);
	scr_trigger_global_reactions(_card,_target,_channel,_calculated_dmg);
		
	////////////
	// EFFECT //
	////////////
	scr_create_combat_effect(undefined,spr_effect_missile,_channel.x,_channel.y,100,c_lime,0.4,0.4,_target.x,_target.y,75,"Sparkling Projectile",undefined,"Effects");
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_magic_missile,0,false);	
	
	var _rand = choose("Poison","Bleed","Venom");
	switch(_rand){
	 	case "Poison":
			////////////
			// POISON //
			////////////
			var _counter1 = scr_get_status_counter(_target,"General",undefined,"Poison");		
			if (_counter1 == undefined){		
				scr_create_status_counter(_target,"Poison","Target is poisoned for 3 turns",_card,"End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _target._creature_statuses, spr_status_poison);
				_target._status_poisoned = true;
				scr_create_combat_popup(_target,"Poisoned","Poison",0,0);
				scr_create_combat_effect(_target,spr_effect_dripping,0,0,36,c_lime,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");				
			} 
			else {
				_counter1._counter_life = 3;
				_counter1._counter_stacks += 1;
			}
		break;
		
		case "Venom":
			///////////
			// VENOM //
			///////////
				var _counter2 = scr_get_status_counter(_target,"General",undefined,"Venom");		
				if (_counter2 == undefined){		
					scr_create_status_counter(_target,"Venom","Target is envenomed for 3 turns, each venom stack deals damage and reduces damage done","Reaction","End",scr_status_venom_tick, false, undefined, 3, 1, "3 * (stacks)", 0, "General", _target._creature_statuses, spr_status_venom);
					scr_create_combat_popup(_target,"Envenomed","Venom",0,0);
					scr_create_combat_effect(_target,spr_effect_dripping,0,0,36,c_purple,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
					_target._status_venom = true;
					//apply debuff stacks from venom
					_target._creature_attack_linear--;					
				} 
				else {
					_counter2._counter_life = 3;
					_counter2._counter_stacks +=1;
					_target._creature_attack_linear--;
				}
		
		break;
		
		case "Bleed":
			///////////
			// BLEED //
			///////////
			if (_target._creature_hp_current < _tar_snapshot){
				var _counter3 = scr_get_status_counter(_target,"General",undefined,"Bleed");		
				if (_counter3 == undefined){		
					scr_create_status_counter(_target,"Bleed","Target is bleeding for 5 turns.",_card,"End",scr_status_bleed_tick, false, undefined, 5, 1, "2*(stacks)", 0, "General", _target._creature_statuses, spr_status_bleed);
					_target._status_bleeding = true;
					scr_create_combat_popup(_target,"Bleeding","Damage",0,0);
					scr_create_combat_effect(_target,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");					
				} 
				else {
					_counter3._counter_life = 5;
					_counter3._counter_stacks += 1;
			}
			} 
			else {
				scr_create_combat_popup(_target,"Shield blocked bleed","Default",0,0);
			}
		break;
		
	}
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));
	
	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_ref[?"name"] + " on " + _target._creature_name + " for " + string(_calculated_dmg));		
}