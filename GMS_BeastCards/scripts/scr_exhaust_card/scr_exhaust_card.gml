//===============================================================================//
//
// SCR_EXHAUST_CARD
// FUNCTION: Moves a battle card from the player's hand to the exhaust pile.
//           Updates the card's location and refreshes hand positioning.
//
//===============================================================================//
function scr_exhaust_card(_ref_card){

	var _list_hand = obj_battle_player_controller._list_battle_hand;
	var _list_exhaust = obj_battle_player_controller._list_battle_exhaust;

	var _it_card = ds_list_find_index(_list_hand,_ref_card);

	if (_it_card != -1){
		ds_list_delete(_list_hand,_it_card);
	}

	ds_list_add(_list_exhaust,_ref_card);

	_ref_card.x = room_width - 70;
	_ref_card.y = room_height - 100;

	_ref_card._str_location = "EXHAUST";

	scr_reposition_cards();
}