//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DISCARD_CARD
// FUNCTION: Moves a battle Card from the player's Hand into the Discard pile.
//           Immediately repositions the remaining Hand and animates the
//           discarded Card from its previous position into the Discard pile.
//
// INPUT:    _ref_card - Player battle Card instance being discarded.
// USES:     Player battle Hand and Discard lists, hand repositioning,
//           Card movement animation, and expend VFX.
//
//===============================================================================//

function scr_battle_discard_card(_ref_card){

	#region VALIDATION

	//---------------//
	//VALIDATE CARD//
	//---------------//
	if (!instance_exists(_ref_card)){
		return false;
	}

	//---------//
	//GET LISTS//
	//---------//
	var _list_hand = obj_battle_player_controller._list_battle_hand;
	var _list_discard = obj_battle_player_controller._list_battle_discard;

	//----------------//
	//FIND HAND CARD//
	//----------------//
	var _it_card = ds_list_find_index(_list_hand,_ref_card);

	if (_it_card == -1){
		return false;
	}

	#endregion

	#region DISCARD CARD

	//----------------//
	//STORE MOVEMENT//
	//----------------//
	var _val_move_start_x = _ref_card.x;
	var _val_move_start_y = _ref_card.y;

	var _val_discard_x = room_width - 150;
	var _val_discard_y = room_height - 100;

	var _ct_move_duration = 8;

	//-----------------//
	//REMOVE FROM HAND//
	//-----------------//
	ds_list_delete(_list_hand,_it_card);

	//----------------//
	//ADD TO DISCARD//
	//----------------//
	ds_list_add(_list_discard,_ref_card);

	//----------------//
	//UPDATE LOCATION//
	//----------------//
	_ref_card._str_location = "DISCARD";

	#endregion

	#region PRESENTATION

	//------------------//
	//REFRESH REMAINING//
	//------------------//
	scr_battle_reposition_hand();

	//----------------//
	//START MOVEMENT//
	//----------------//
	scr_battle_start_card_move_animation(
		_ref_card,
		"DISCARD",
		_val_move_start_x,
		_val_move_start_y,
		_val_discard_x,
		_val_discard_y,
		_ct_move_duration,
		0
	);

	//----------------//
	//EXPEND FEEDBACK//
	//----------------//
	scr_battle_vfx_expend(undefined,_val_discard_x,_val_discard_y,_ct_move_duration);

	#endregion

	return true;
}