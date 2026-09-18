//===============================================================================//
//
// SCRIPT: SCR_BATTLE_RECOVER_SPECIFIC_EXHAUSTED_CARD
// FUNCTION: Moves one selected exhausted Card into the player's Hand.
//           Confirms that it is still eligible for recovery.
//           Uses the existing Card-pile movement and Hand layout systems.
//
// ARGUMENTS: _ref_card is the selected Card instance.
//            _str_color is the required color.
//            _ref_excluded_card is an optional excluded source Card.
// RETURNS: True if recovery succeeds; otherwise false.
//
//===============================================================================//

function scr_battle_recover_specific_exhausted_card(_ref_card,_str_color,_ref_excluded_card=undefined){

	//================//
	//VALIDATE CARD//
	//================//
	if (!instance_exists(_ref_card)){
		return false;
	}

	if (!instance_exists(obj_battle_player_controller)){
		return false;
	}

	//================//
	//CHECK ELIGIBILITY//
	//================//
	var _arr_candidates = scr_battle_get_exhausted_color_candidates(
		_str_color,
		_ref_excluded_card
	);

	var _flag_eligible = false;

	for (var _it_card = 0;_it_card < array_length(_arr_candidates);_it_card++){

		if (_arr_candidates[_it_card] == _ref_card){

			_flag_eligible = true;

			break;
		}
	}

	if (!_flag_eligible){
		return false;
	}

	//================//
	//GET CARD PILES//
	//================//
	var _list_exhaust = obj_battle_player_controller._list_battle_exhaust;
	var _list_hand = obj_battle_player_controller._list_battle_hand;

	var _it_exhaust = ds_list_find_index(_list_exhaust,_ref_card);

	if (_it_exhaust == -1){
		return false;
	}

	//====================//
	//REMOVE FROM EXHAUST//
	//====================//
	ds_list_delete(_list_exhaust,_it_exhaust);

	//================//
	//RETURN TO HAND//
	//================//
	ds_list_add(_list_hand,_ref_card);

	_ref_card._str_location = "HAND";

	//================//
	//REPOSITION HAND//
	//================//
	// Calculates the recovered Card's destination before animating it.

	scr_battle_reposition_hand();

	//================//
	//MOVE ANIMATION//
	//================//
	scr_battle_move_card_between_piles(
		_ref_card,
		"EXHAUST",
		"HAND",
		10
	);

	//================//
	//DEBUG RECOVERY//
	//================//
	scr_debug_log(
		"CARDS",
		"RECOVER",
		_ref_card._ref_card,
		"PLAYER RECOVERED " +
		string_upper(_ref_card._ref_card._str_card_name) +
		" FROM EXHAUST TO HAND" +
		" | COLOR: " + string_upper(_str_color) +
		" | HAND: " + string(ds_list_size(_list_hand)) +
		" | EXHAUST: " + string(ds_list_size(_list_exhaust)),
		"BATTLE",
		"SCR_BATTLE_RECOVER_SPECIFIC_EXHAUSTED_CARD"
	);

	return true;
}