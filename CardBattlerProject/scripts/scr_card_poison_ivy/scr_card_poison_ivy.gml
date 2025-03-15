//////////////////////////////////////////////////////////////////////
//						SCR_CARD_POISON_IVY							//
//																	//
// > POSION UP TO THREE TARGETS FOR 3 TURNS							//	
//////////////////////////////////////////////////////////////////////
function scr_card_poison_ivy(_card,_channel,_target){
	/////////////////
	// LEFT TARGET //
	/////////////////
	if (_target._left_unit != undefined){	
		var _left_target = _target._left_unit;

		////////////
		// POISON //
		////////////
		var _counter = scr_get_status_counter(_left_target,"General",undefined,"Poison");		
		if (_counter == undefined){		
			scr_create_status_counter(_left_target,"Poison","Target is poisoned for 3 turns",_card,"End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _left_target._creature_statuses, spr_status_poison);
			_left_target._status_poisoned = true;		
		} 
		else {
			_counter._counter_life = 3;
			_counter._counter_stacks+= 1;
		}

		scr_trigger_minion_reactions(_card,_left_target,_channel,0);	
		
		////////////
		// EFFECT //
		////////////		
		scr_create_combat_popup(_left_target,"Poisoned","Poison",0,0);
		scr_create_combat_effect(_left_target,spr_effect_poison_ivy,0,0);
		
		///////////
		// DEBUG //
		///////////
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _left_target._creature_name);			

	}
	
	//////////////////
	// RIGHT TARGET //
	//////////////////
	if (_target._right_unit != undefined){
		var _right_target = _target._right_unit;

		////////////
		// POISON //
		////////////
		var _counter = scr_get_status_counter(_right_target,"General",undefined,"Poison");		
		if (_counter == undefined){		
			scr_create_status_counter(_right_target,"Poison","Target is poisoned for 3 turns",_card,"End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _right_target._creature_statuses, spr_status_poison);
			_right_target._status_poisoned = true;	
		} 
		else {
			_counter._counter_life = 3;
			_counter._counter_stacks+= 1;
		}

		scr_trigger_minion_reactions(_card,_right_target,_channel,0);	
		
		////////////
		// EFFECT //
		////////////		
		scr_create_combat_popup(_right_target,"Poisoned","Poison",0,0);
		scr_create_combat_effect(_right_target,spr_effect_poison_ivy,0,0);
		
		///////////
		// DEBUG //
		///////////
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _right_target._creature_name);			
	
	}
	
	///////////////////
	// MIDDLE TARGET //
	///////////////////
	#region MIDDLE TARGET
		////////////
		// POISON //
		////////////
		var _counter = scr_get_status_counter(_target,"General",undefined,"Poison");		
		if (_counter == undefined){		
			scr_create_status_counter(_target,"Poison","Target is poisoned for 3 turns",_card,"End",scr_status_poison_tick, false, undefined, 3, 1, "3 + (stacks)", 0, "General", _target._creature_statuses, spr_status_poison);
			_target._status_poisoned = true;
		} 
		else {
			_counter._counter_life = 3;
			_counter._counter_stacks += 1;
		}

		scr_trigger_minion_reactions(_card,_target,_channel,0);	
		
		////////////
		// EFFECT //
		////////////		
		scr_create_combat_popup(_target,"Poisoned","Poison",0,0);
		scr_create_combat_effect(_target,spr_effect_poison_ivy,0,0);
		
		///////////
		// DEBUG //
		///////////
		show_debug_message("COMBAT: " + _channel._creature_name + " casts " + _card._card_name + " on " + _target._creature_name);		
	#endregion
	
	///////////
	// SOUND //
	///////////
	audio_play_sound(snd_effect_poison_ivy,0,false);	
	
	
	
	////////////
	// BANNER //
	////////////
	scr_create_combat_banner(c_black,"" + _channel._creature_name + " casts " + _card._card_ref[?"name"]);
}