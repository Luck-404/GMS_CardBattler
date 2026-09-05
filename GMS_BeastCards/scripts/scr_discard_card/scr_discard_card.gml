//===============================================================================//
//
// SCRIPT: SCR_DISCARD_CARD
// FUNCTION: Moves a battle card from the player's hand to the discard pile.
//           Immediately repositions the remaining hand.
//           Animates the discarded card from its old hand position to the pile.
//
//===============================================================================//

function scr_discard_card(_ref_card){

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!instance_exists(_ref_card)){
		return false;
	}

	//---------//
	//GET LISTS//
	//---------//
	var _list_hand =
		obj_battle_player_controller
			._list_battle_hand;

	var _list_discard =
		obj_battle_player_controller
			._list_battle_discard;

	//----------------//
	//FIND HAND CARD//
	//----------------//
	var _it_card =
		ds_list_find_index(
			_list_hand,
			_ref_card
		);

	if (_it_card == -1){
		return false;
	}

	//----------------//
	//STORE START POS//
	//----------------//
	var _val_start_x =
		_ref_card.x;

	var _val_start_y =
		_ref_card.y;

	//-----------------//
	//REMOVE FROM HAND//
	//-----------------//
	ds_list_delete(
		_list_hand,
		_it_card
	);

	//----------------//
	//ADD TO DISCARD//
	//----------------//
	ds_list_add(
		_list_discard,
		_ref_card
	);

	//----------------//
	//UPDATE LOCATION//
	//----------------//
	_ref_card._str_location =
		"DISCARD";

	//------------------//
	//REFRESH REMAINING//
	//------------------//
	scr_reposition_cards();

	//----------------//
	//START MOVEMENT//
	//----------------//
	scr_start_card_move_animation(
		_ref_card,
		"DISCARD",
		_val_start_x,
		_val_start_y,
		room_width - 150,
		room_height - 100,
		8,
		0
	);

	return true;
}