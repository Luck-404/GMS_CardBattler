//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DRAW_SPECIFIC_CARD
// FUNCTION: Draws one specified battle Card instance from the player's draw pile.
//           Moves that exact Card from Deck to Hand, refreshes hand layout,
//           and logs the completed specific draw and its source.
//
// INPUTS:   _ref_card - Specific battle Card instance requested from the Deck.
//           _str_reason - Context that requested the specific draw.
// USES:     Player battle Deck and Hand lists and shared hand repositioning.
//
//===============================================================================//

function scr_battle_draw_specific_card(_ref_card,_str_reason="SPECIFIC"){

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
	var _list_deck = obj_battle_player_controller._list_battle_deck;
	var _list_hand = obj_battle_player_controller._list_battle_hand;

	//----------------//
	//FIND DECK CARD//
	//----------------//
	var _it_card = ds_list_find_index(_list_deck,_ref_card);

	if (_it_card == -1){
		return false;
	}

	if (_ref_card._str_location != "DECK"){
		return false;
	}

	#endregion

	#region DRAW CARD

	//-----------------//
	//REMOVE FROM DECK//
	//-----------------//
	ds_list_delete(_list_deck,_it_card);

	//-------------//
	//ADD TO HAND//
	//-------------//
	ds_list_add(_list_hand,_ref_card);

	_ref_card._str_location = "HAND";

	//----------------//
	//REFRESH HAND GUI//
	//----------------//
	scr_battle_reposition_hand();

	//-----------------------//
	//FLY FROM DECK TO HAND//
	//-----------------------//
	scr_battle_move_card_between_piles(_ref_card,"DECK","HAND",8);

	#endregion

	#region DEBUG

	//----------------//
	//LOG SPECIFIC DRAW//
	//----------------//
	_str_reason = string_upper(_str_reason);

	var _str_draw_message =
		"PLAYER DREW " +
		string_upper(_ref_card._ref_card._str_card_name);

	if (_str_reason == "TUTOR"){
		_str_draw_message =
			"PLAYER TUTORED " +
			string_upper(_ref_card._ref_card._str_card_name) +
			" FROM DECK";
	}

	_str_draw_message +=
		" | HAND: " + string(ds_list_size(_list_hand)) +
		" | DECK: " + string(ds_list_size(_list_deck));

	scr_debug_log(
		"CARDS",
		"TUTOR",
		_ref_card._ref_card,
		_str_draw_message,
		"BATTLE",
		"SCR_BATTLE_DRAW_SPECIFIC_CARD"
	);

	#endregion

	return true;
}
