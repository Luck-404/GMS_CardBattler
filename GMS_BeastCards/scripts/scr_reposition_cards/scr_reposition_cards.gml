//===============================================================================//
//
// SCR_REPOSITION_CARDS
// FUNCTION: Repositions all cards currently in the player's hand.
//           Centers the hand at the bottom of the battle screen.
//
//===============================================================================//
function scr_reposition_cards(){

	var _val_base_x = 548;
	var _val_card_spacing = 15;
	var _val_card_width = 120;

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