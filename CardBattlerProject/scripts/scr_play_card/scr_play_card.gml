// When a card is played, call scr_play_card
function scr_play_card(_card_script, _target_creature, _card_cost, _card_exhausts) {
	//////////
	// ECHO //
	//////////
	if (global.echo == true){		
	//show_debug_message("!!=== SCR_PLAY_CARD: CARD " + string(_card_script) + " ECHOING... ===!!");		
	//	//if this new card is an echo, add to the echo counter
		if (_card_script == scr_card_echo){	
			global.echo_count +=1;
			//show_debug_message("!!=== SCR_PLAY_CARD: ECHO COUNTER INCREASED BY 1, NOW..." + string(global.echo_count) +" ===!!");		
			ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,global.card_selected));
			//ds_list_delete(global.player_deck, ds_list_find_index(global.player_deck,global.card_selected));
			ds_list_add(global.player_exhaust_pile,global.card_selected);
			// Reset the selected card
			global.card_selected = undefined;
			//show_debug_message("!!=== SCR_PLAY_CARD: ECHO CARD EXHAUSTED! ===!!");					
		} 
		//otherwise play the card out for as many echoes as possible
		else {			
			for (var _j = -1; _j < global.echo_count; _j++){	
				audio_play_sound(snd_effect_echoing,0,false);	
				_card_script(_target_creature);
			}
			global.echo_count = 0;
			global.echo = false;
			//subract cost once
			global.cur_max_mana  = global.cur_max_mana  - _card_cost;
		}
				
	}
		
	////////////
	// NORMAL //
	////////////
	else {
		//show_debug_message("!!=== SCR_PLAY_CARD: CARD " + string(_card_script) + " EXECUTING NORMALLY... ===!!");		
		// Execute the attached script of the card
		_card_script(_target_creature);
		//subract cost once
		global.cur_max_mana  = global.cur_max_mana  - _card_cost;
	}
	
///////////////
// POST PLAY //
///////////////
	
	//////////////////////////////////////////////////
	// IF THE CARD EXHAUSTS, PUT IT IN EXHAUST DECK //
	//////////////////////////////////////////////////
	if (_card_exhausts == true){
		//show_debug_message("!!=== SCR_PLAY_CARD: EXHAUSTING CARD! ===!!");			
		ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,global.card_selected));
		//ds_list_delete(global.player_deck, ds_list_find_index(global.player_deck,global.card_selected));
		ds_list_add(global.player_exhaust_pile,global.card_selected);
		// Reset the selected card
		global.card_selected = undefined;
	} 
		
	/////////////////////////////////
	// OTHERWISE RETURN IT TO DECK //
	/////////////////////////////////
	else {		
		//show_debug_message("!!=== SCR_PLAY_CARD: PLACING CARD " + string(_card_script) + " BACK INTO DECK! ===!!");		
		// Put the card back into the deck
		ds_list_add(global.player_deck, global.card_selected);
		ds_list_delete(global.player_hand, ds_list_find_index(global.player_hand,global.card_selected));

		// Reset the selected card
		global.card_selected = undefined;
	}
}