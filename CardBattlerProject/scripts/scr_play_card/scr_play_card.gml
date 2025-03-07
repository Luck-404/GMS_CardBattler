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
		switch(_card_script){
			case scr_card_echo:
				if (global.echo_count != 0){
					global.echo_count += 1;
				} else {
					for (var _j = -1; _j < global.echo_count; _j++){	
						audio_play_sound(snd_effect_echoing,0,false);	
						_card_script(_card_ref,_channel_creature,_target_creature);
					}
					global.echo_count = 0;
					//subract cost once
					global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
				}
				scr_exhaust(_card);
			break;
			
			default:
				_card_script(_card_ref,_channel_creature,_target_creature);
				//subract cost once
				global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
				if (_card_ref[?"exhausts"] == true){
					scr_exhaust(_card);
				}
				else {
					scr_discard(_card);
				}
			break;
		}
	}
	
	//////////////////////
	// HANDLE MANA COST //
	//////////////////////	
	global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];

	//////////
	// CAST //
	//////////
	_card_script(_card_ref,_channel_creature,_target_creature);

	//////////////////////////////////
	// HANDLE DISCARDING/EXHAUSTING //
	//////////////////////////////////
	if (_card_ref[?"exhausts"] == true){
		scr_exhaust(_card);
	}
	else {
		scr_discard(_card);
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
		obj_creature._selected_channel = false;
		obj_creature._selected_target = false;
	}			
			
}