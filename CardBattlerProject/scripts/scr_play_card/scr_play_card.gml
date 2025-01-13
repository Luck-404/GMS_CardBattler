// When a card is played, call scr_play_card
function scr_play_card(_card_script, _target_creature,_card_cost) {
	show_debug_message("\n === PLAYING CARDS === \n");
	
	//if echo is in place, play card twice
	if (global.echo == true){		
		if (_card_script == scr_card_echo){	
			global.echo_count +=1;
			show_debug_message("!!! REMOVING ECHO FROM PLAY !!!");		
			ds_list_delete(global.current_hand, ds_list_find_index(global.current_hand,global.card_selected));
			//ds_list_delete(global.card_inventory, ds_list_find_index(global.card_inventory,global.card_selected));
			ds_list_add(global.exhausted,global.card_selected);
			// Reset the selected card
			global.card_selected = undefined;
		} else {
			for (var _j = -1; _j < global.echo_count; _j++){	
				audio_play_sound(snd_effect_echoing,0,false);	
				_card_script(_target_creature);
			}
			global.echo_count = 0;
			global.echo = false;
			//subract cost once
			global.current_mana = global.current_mana - _card_cost;
		}
				
	}
		
	//otherwise play normally
	else {
		// Execute the attached script of the card
		_card_script(_target_creature);
		//subract cost once
		global.current_mana = global.current_mana - _card_cost;
	}
	
	if (_card_script != scr_card_echo){
		
		if (_card_script == scr_card_inspiration){
			show_debug_message("!!! REMOVING INSPIRATION FROM PLAY !!!");		
			ds_list_delete(global.current_hand, ds_list_find_index(global.current_hand,global.card_selected));
			//ds_list_delete(global.card_inventory, ds_list_find_index(global.card_inventory,global.card_selected));
			ds_list_add(global.exhausted,global.card_selected);
			// Reset the selected card
			global.card_selected = undefined;
		} else {		
			// Put the card back into the deck
			ds_list_add(global.card_inventory, global.card_selected);
			ds_list_delete(global.current_hand, ds_list_find_index(global.current_hand,global.card_selected));

			// Reset the selected card
			global.card_selected = undefined;
		}
	}
}