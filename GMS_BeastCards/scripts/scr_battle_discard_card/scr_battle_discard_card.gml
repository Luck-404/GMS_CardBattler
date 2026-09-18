//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DISCARD_CARD
// FUNCTION: Moves a battle Card from the player's Hand into the Discard pile.
//           Repositions the remaining Hand, animates the discarded Card,
//           and logs the completed Card movement.
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

	if (!is_struct(_ref_card._ref_card)){
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
	scr_battle_move_card_between_piles(_ref_card,"HAND","DISCARD",8);

	#endregion

	#region DEBUG

	//----------------//
	//LOG DISCARD//
	//----------------//
	scr_debug_log(
		"CARDS",
		"DISCARD",
		_ref_card._ref_card,
		"PLAYER DISCARDED " + string_upper(_ref_card._ref_card._str_card_name) +
		" | HAND: " + string(ds_list_size(_list_hand)) +
		" | DISCARD: " + string(ds_list_size(_list_discard)),
		"BATTLE",
		"SCR_BATTLE_DISCARD_CARD"
	);

	#endregion

	return true;
}
