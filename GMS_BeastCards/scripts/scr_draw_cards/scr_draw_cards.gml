//===============================================================================//
//
// SCR_DRAW_CARDS
// FUNCTION: Draws cards from the player's battle deck into the hand.
//           Refills the deck from discard when needed.
//           Repositions the player's hand after drawing.
//
//===============================================================================//
function scr_draw_cards(_ct_amount){

	audio_play_sound(snd_card_draw,0,false);

	var _val_base_x = 548;
	var _val_card_spacing = 15;
	var _val_card_width = 120;

	var _ct_drawn = 0;

	while (_ct_drawn < _ct_amount){

		if (ds_list_size(obj_battle_player_controller._list_battle_deck) <= 0){

			if (ds_list_size(obj_battle_player_controller._list_battle_discard) > 0){
				scr_gather_discards();
			}
			else{
				break;
			}
		}

		var _list_deck = obj_battle_player_controller._list_battle_deck;

		var _it_card = irandom(ds_list_size(_list_deck) - 1);
		var _ref_card = ds_list_find_value(_list_deck,_it_card);

		ds_list_add(obj_battle_player_controller._list_battle_hand,_ref_card);
		ds_list_delete(_list_deck,_it_card);

		_ref_card._str_location = "HAND";

		_ct_drawn++;
	}

	var _list_hand = obj_battle_player_controller._list_battle_hand;
	var _ct_hand = ds_list_size(_list_hand);

	var _val_total_width = (_ct_hand * _val_card_width) + ((_ct_hand - 1) * _val_card_spacing);
	var _val_start_x = _val_base_x - (_val_total_width * 0.5) + (_val_card_width * 0.5);

	for (var _it_card = 0; _it_card < _ct_hand; _it_card++){

		var _ref_card = ds_list_find_value(_list_hand,_it_card);

		_ref_card.x = _val_start_x + (_it_card * (_val_card_width + _val_card_spacing));
		_ref_card.y = room_height - 100;
	}
}