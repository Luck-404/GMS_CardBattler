//////////////////////////////////////////////////////////////////////
//							SCR_PLAY_CARD							//
//																	//
// > PPLAYS AN INPUT CARD											//
//////////////////////////////////////////////////////////////////////
function scr_play_card(_card, _channel_creature, _target_creature) {
	var _card_ref = _card._card_ref;
	var _card_script = _card_ref[?"script"];
	

	
	////////////////
	// TARGETLESS //
	////////////////
	if (_target_creature == "Targetless"){
		show_debug_message("COMBAT: " + _channel_creature._creature_team + " unit " + _channel_creature._creature_name + " plays card " + _card._card_name);		
		if (global.echo_count != 0){
			var _tmp = global.echo_count;
			for (var _j = -1; _j < _tmp; _j++){	
				audio_play_sound(snd_effect_echoing,0,false);	
				_card_script(_card_ref,_channel_creature,_target_creature);
			}
			global.echo_count = 0;
		} else {
			_card_script(_card_ref,_channel_creature,_target_creature);
		}
		//subract cost once
		global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
		if (_card_ref[?"exhausts"] == true){
			scr_exhaust(_card);
		}
		else {
			scr_discard(_card);
		}
	} 
	else {
		show_debug_message("COMBAT: " + _channel_creature._creature_team + " unit " + _channel_creature._creature_name + " plays card " + _card._card_name + " targeting " + _target_creature._creature_name);
		//////////////////////
		// HANDLE MANA COST //
		//////////////////////	
		global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];

		//////////
		// CAST //
		//////////
		if (global.echo_count != 0){
			var _tmp = global.echo_count;
			for (var _j = -1; _j < _tmp; _j++){	
				audio_play_sound(snd_effect_echoing,0,false);	
				_card_script(_card_ref,_channel_creature,_target_creature);
			}
			global.echo_count = 0;
		} else {
			_card_script(_card_ref,_channel_creature,_target_creature);
		}
		
		//////////////////////////////////
		// HANDLE DISCARDING/EXHAUSTING //
		//////////////////////////////////
		if (_card_ref[?"exhausts"] == true){
			scr_exhaust(_card);
		}
		else {
			scr_discard(_card);
		}
	}
		
	/////////////////////////////////////////
	// RESET PLAYER VARIABLES FOR NEW CAST //
	/////////////////////////////////////////
	//reset player's selected and such
	obj_player._card_selected = undefined;	
	obj_player._channel_selected = undefined;
	obj_player._target_selected = undefined;
			
	with(obj_card){
		obj_card._active = false;
		obj_card._selected = false;
	}
			
	with(obj_creature){
		obj_creature._active = false;
		obj_creature._selected_channel = false;
		obj_creature._selected_target = false;
	}			
	
	obj_player._flag_check_card = false;
	obj_player._flag_check_channel = false;
			
}