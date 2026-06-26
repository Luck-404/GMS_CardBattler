//===============================================================================//
//
// SCR_DISCARD_CARD
// FUNCTION: Moves a battle card from the player's hand to the discard pile.
//           Updates the card's location and refreshes hand positioning.
//
//===============================================================================//
function scr_discard_card(_ref_card){

	var _list_hand = obj_battle_player_controller._list_battle_hand;
	var _list_discard = obj_battle_player_controller._list_battle_discard;

	//
	// REMOVE FROM HAND
	//
	var _it_card = ds_list_find_index(_list_hand,_ref_card);

	ds_list_delete(_list_hand,_it_card);

	//
	// ADD TO DISCARD
	//
	ds_list_add(_list_discard,_ref_card);

	//
	// MOVE CARD
	//
	_ref_card.x = room_width - 150;
	_ref_card.y = room_height - 100;

	//
	// UPDATE LOCATION
	//
	_ref_card._str_location = "DISCARD";

	//
	// REFRESH HAND
	//
	scr_reposition_cards();
}