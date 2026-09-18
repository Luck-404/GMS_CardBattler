//===============================================================================//
//
// SCRIPT: SCR_BATTLE_EXHAUST_CARD
// FUNCTION: Moves a battle Card from the player's Hand into the Exhaust pile.
//           Repositions the remaining Hand, animates the exhausted Card,
//           and logs the completed Card movement.
//
// INPUT:    _ref_card - Player battle Card instance being exhausted.
// USES:     Player battle Hand and Exhaust lists, hand repositioning,
//           Card movement animation, and expend VFX.
//
//===============================================================================//

function scr_battle_exhaust_card(_ref_card){

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
	var _list_exhaust = obj_battle_player_controller._list_battle_exhaust;

	//----------------//
	//FIND HAND CARD//
	//----------------//
	var _it_card = ds_list_find_index(_list_hand,_ref_card);

	if (_it_card == -1){
		return false;
	}

	#endregion

	#region EXHAUST CARD

	//-----------------//
	//REMOVE FROM HAND//
	//-----------------//
	ds_list_delete(_list_hand,_it_card);

	//----------------//
	//ADD TO EXHAUST//
	//----------------//
	ds_list_add(_list_exhaust,_ref_card);

	//----------------//
	//UPDATE LOCATION//
	//----------------//
	_ref_card._str_location = "EXHAUST";

	#endregion

	#region PRESENTATION

	//------------------//
	//REFRESH REMAINING//
	//------------------//
	scr_battle_reposition_hand();

	//----------------//
	//START MOVEMENT//
	//----------------//
	scr_battle_move_card_between_piles(_ref_card,"HAND","EXHAUST",8);

	#endregion

	#region DEBUG

	//----------------//
	//LOG EXHAUST//
	//----------------//
	scr_debug_log(
		"CARDS",
		"EXHAUST",
		_ref_card._ref_card,
		"PLAYER EXHAUSTED " + string_upper(_ref_card._ref_card._str_card_name) +
		" | HAND: " + string(ds_list_size(_list_hand)) +
		" | EXHAUST: " + string(ds_list_size(_list_exhaust)),
		"BATTLE",
		"SCR_BATTLE_EXHAUST_CARD"
	);

	#endregion

	return true;
}
