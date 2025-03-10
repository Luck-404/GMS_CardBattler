//////////////////////////////////////////////////////////////////////
//							SCR_PLAY_CARD							//
//																	//
// > PLAYS AN INPUT CARD THROUGH THE CHANNEL CREATURE CENTERED ON	//
//	 THE TARGET. THE CARD SCRIPTS THEMSELVES HANDLE A LOT OF THE	//
//   LOGIC.															//
//////////////////////////////////////////////////////////////////////
function scr_play_card(_card, _channel_creature, _target_creature) {
	global.latest_card = _card;
	global.latest_channel = _channel_creature;
	global.latest_target = _target_creature;	
		
	
	var _card_ref = _card._card_ref;
	var _card_script = _card_ref[?"script"];
	
	if (_card_ref[?"type"] != "Attack"){
		global.latest_damage_done = 0;
	}

	////////////////
	// TARGETLESS //
	////////////////
	if (_target_creature == "Targetless"){
		show_debug_message("COMBAT: " + _channel_creature._creature_team + " unit " + _channel_creature._creature_name + " plays card " + _card._card_name);		
		
		/////////////
		// ECHOING //
		/////////////
		if (global.echo_count != 0){
			//add to echo counter
			if (_card_script == scr_card_echo){
				global.echo_count++;
			} 
			//echo out the card
			else {
				var _tmp = global.echo_count;
				for (var _j = -1; _j < _tmp; _j++){	
					audio_play_sound(snd_effect_echoing,0,false);	
					_card_script(_card_ref,_channel_creature,_target_creature);
				}
				global.echo_count = 0;
			}
		} 
		/////////////////
		// NOT ECHOING //
		/////////////////
		else {
			_card_script(_card_ref,_channel_creature,_target_creature);
		}
		
		///////////////////
		// SUBTRACT MANA //
		///////////////////
		global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];
		
		//////////////////
		// CLEANUP CARD //
		//////////////////
		if (_card_ref[?"exhausts"] == true){
			scr_exhaust(_card);
		}
		else {
			scr_discard(_card);
		}
	} 
	
	//////////////////
	// NORMAL CARDS //
	//////////////////
	else {
		show_debug_message("COMBAT: " + _channel_creature._creature_team + " unit " + _channel_creature._creature_name + " plays card " + _card._card_name + " targeting " + _target_creature._creature_name);
		///////////////////
		// SUBTRACT MANA //
		///////////////////
		global.cur_mana  = global.cur_mana  - _card_ref[?"cost"];

		//////////
		// ECHO //
		//////////
		if (global.echo_count != 0){
			var _tmp = global.echo_count;
			for (var _j = -1; _j < _tmp; _j++){	
				audio_play_sound(snd_effect_echoing,0,false);	
				_card_script(_card_ref,_channel_creature,_target_creature);
			}
			global.echo_count = 0;
		} 
		/////////////////
		// PLAY NORMAL //
		/////////////////
		else {
			_card_script(_card_ref,_channel_creature,_target_creature);
		}
		
		//////////////////
		// CLEANUP CARD //
		//////////////////
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
scr_reset_playstate();
}