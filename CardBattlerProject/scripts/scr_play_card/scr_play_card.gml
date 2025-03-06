//////////////////////////////////////////////////////////////////////
//							SCR_PLAY_CARD							//
//																	//
// > PPLAYS AN INPUT CARD											//
//////////////////////////////////////////////////////////////////////
function scr_play_card(_card_ref, _channel_creature, _target_creature) {
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
						_card_script(_target_creature,1);
					}
					global.echo_count = 0;
					//subract cost once
					global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
				}
				scr_exhaust(_card_ref);
			break;
			
			default:
				_card_script(_target_creature,1);
				//subract cost once
				global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
				if (_card_ref[?"exhausts"] == true){
					scr_exhaust(_card_ref);
				}
				else {
					scr_discard(_card_ref);
				}
			break;
		}
	}
		
	///////////////////////
	// CALC DAMAGE BONUS //
	///////////////////////
	var _base_dmg = _card_ref[?"damage"];
	var _dmg_mult = scr_calculate_damage(_channel_creature,_base_dmg,_target_creature);
	
	//////////////////////
	// HANDLE MANA COST //
	//////////////////////	
	global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];

	//////////
	// CAST //
	//////////
	_card_script(_card_ref,_dmg_mult,_base_dmg,_channel_creature,_target_creature);

	//////////////////////////////////
	// HANDLE DISCARDING/EXHAUSTING //
	//////////////////////////////////
	if (_card_ref[?"exhausts"] == true){
		scr_exhaust(_card_ref);
	}
	else {
		scr_discard(_card_ref);
	}
}