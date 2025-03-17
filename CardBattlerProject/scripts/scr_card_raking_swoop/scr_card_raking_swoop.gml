//////////////////////////////////////////////////////////////////////
//						scr_card_raking_swoop						//
//																	//
// > dmg and bleed targets											//	
//////////////////////////////////////////////////////////////////////
function scr_card_raking_swoop(_card,_channel,_target){
	/////////////////
	// LEFT TARGET //
	/////////////////
	if (_target._left_unit != undefined){
		var _left_target = _target._left_unit;
		//snapshot hp
		var _target_start_hp = _left_target._creature_hp_current;
	
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_left_target,0,0);
	
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_left_target, _calculated_dmg);
		scr_trigger_global_reactions(_card,_left_target,_channel,_calculated_dmg);
		
		///////////
		// BLEED //
		///////////
		if (_left_target._creature_hp_current < _target_start_hp){

			var _counter = scr_get_status_counter(_left_target,"General",undefined,"Bleed");		
			if (_counter == undefined){		
				scr_create_status_counter(_left_target,"Bleed","Target is bleeding for 5 turns.",_card,"End",scr_status_bleed_tick, false, undefined, 5, 1, "2*(stacks)", 0, "General", _left_target._creature_statuses, spr_status_bleed);
				_left_target._status_bleeding = true;
			} 
			else {
				_counter._counter_life = 5;
				_counter._counter_stacks += 1;
			}
		
			////////////
			// EFFECT //
			////////////		
			scr_create_combat_popup(_left_target,"Bleeding","Damage",0,0);
			scr_create_combat_effect(_left_target,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		} else {
			scr_create_combat_popup(_left_target,"Shield blocked bleed","Default",0,0);
		}
	}
		
	//////////////////
	// RIGHT TARGET //
	//////////////////
	if (_target._right_unit != undefined){
		var _right_target = _target._right_unit;
		//snapshot hp
		var _target_start_hp = _right_target._creature_hp_current;
	
		///////////////////////
		// CALC DAMAGE BONUS //
		///////////////////////
		var _calculated_dmg = scr_damage_calculator(_card,_channel,_right_target,0,0);
	
		////////////
		// DAMAGE //
		////////////
		scr_damage_creature(_right_target, _calculated_dmg);
		scr_trigger_global_reactions(_card,_right_target,_channel,_calculated_dmg);

		///////////
		// BLEED //
		///////////
		if (_right_target._creature_hp_current < _target_start_hp){

			var _counter = scr_get_status_counter(_right_target,"General",undefined,"Bleed");		
			if (_counter == undefined){		
				scr_create_status_counter(_right_target,"Bleed","Target is bleeding for 5 turns.",_card,"End",scr_status_bleed_tick, false, undefined, 5, 1, "2*(stacks)", 0, "General", _right_target._creature_statuses, spr_status_bleed);
				_right_target._status_bleeding = true;
			} 
			else {
				_counter._counter_life = 5;
				_counter._counter_stacks += 1;
			}
		
			////////////
			// EFFECT //
			////////////		
			scr_create_combat_popup(_right_target,"Bleeding","Damage",0,0);
			scr_create_combat_effect(_right_target,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
		} else {
			scr_create_combat_popup(_right_target,"Shield blocked bleed","Default",0,0);
		}
	}
	
	///////////////////
	// MIDDLE TARGET //
	///////////////////
	#region MIDDLE TARGET
	//snapshot hp
	var _target_start_hp = _target._creature_hp_current;
	
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
	scr_create_combat_effect(_target,spr_effect_big_slice,0,0,5,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	scr_create_combat_effect(_target,spr_effect_swooper,0,0,21,c_white,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	audio_play_sound(snd_effect_raking_swoop,0,false);		
	
	///////////
	// BLEED //
	///////////
	if (_target._creature_hp_current < _target_start_hp){

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
		scr_create_combat_effect(_target,spr_effect_dripping,0,0,17,c_red,0.25,0.25,0,0,0,"Stationary",undefined,"Effects");
	} else {
		scr_create_combat_popup(_target,"Shield blocked bleed","Default",0,0);
	}
#endregion



	///////////
	// DEBUG //
	///////////
	show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _target._creature_name);		
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}