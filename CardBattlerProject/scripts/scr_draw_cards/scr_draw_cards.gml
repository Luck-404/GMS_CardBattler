//////////////////////////////////////////////////////////////////////
//							SCR_DRAW_CARDS							//
//																	//
// > DRAWS X CARDS FROM THE PLAYER DECK TO THE PLAYER'S HAND		//
//////////////////////////////////////////////////////////////////////
function scr_draw_cards(_amount) {
	//audio_play_sound(snd_draw,0,false);
	
    // Draw new cards
    for (var _i = 0; _i < _amount; _i++) {
		//if you have cards in your overall deck
        if (ds_list_size(global.player_deck) > 0) {
            // Randomly select a card from the deck
            var _index = irandom(ds_list_size(global.player_deck) - 1);
            var _ref_card = ds_list_find_value(global.player_deck, _index);
				// Add card to the hand
            ds_list_add(global.player_hand, _ref_card);
			    // Remove card from the deck
            ds_list_delete(global.player_deck, _index);

            // Create the card instance in the roomand update its data
				
            var _x_pos = room_width / 2;
            var _y_pos = room_height / 2;  
            var _ref_card_instance = instance_create_layer(_x_pos, _y_pos, "GUI", obj_card);
            _ref_card_instance._card_name = _ref_card[? "name"];
            _ref_card_instance._card_desc = _ref_card[? "description"];
            _ref_card_instance._card_cost = _ref_card[? "cost"];
            _ref_card_instance._card_script = _ref_card[? "script"];
            _ref_card_instance._card_sprite = _ref_card[? "sprite"];
			_ref_card_instance._card_target = _ref_card[? "target"];
			_ref_card_instance._card_color = _ref_card[? "color"];
			_ref_card_instance._card_type = _ref_card[? "type"];
			_ref_card_instance._card_spec = _ref_card[? "spec"]
			
        }
    }	
}