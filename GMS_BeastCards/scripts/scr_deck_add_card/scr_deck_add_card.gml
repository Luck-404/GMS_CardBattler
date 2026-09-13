//===============================================================================//
//
// SCRIPT: SCR_DECK_ADD_CARD
// FUNCTION: Adds a Card struct to the player's persistent collection.
//           Adds the Card to the Deck while the Deck has fewer than 30 Cards.
//           Otherwise adds the Card to the Library.
//           Marks the Card as obtained in the Logbook and logs its destination.
//
// ARGUMENTS: _stct_new_card is the Card struct being added.
// RETURNS: True when the Card is successfully added; otherwise false.
//
//===============================================================================//

function scr_deck_add_card(_stct_new_card){

	//================//
	//VALIDATE CARD//
	//================//
	if (!is_struct(_stct_new_card)){

		scr_debug_log(
			"CARDS",
			"COLLECTION",
			undefined,
			"CARD ADD FAILED | REASON: INVALID CARD STRUCT",
			"ERROR",
			"SCR_DECK_ADD_CARD"
		);

		return false;
	}

	if (!variable_struct_exists(_stct_new_card,"_str_card_name")){

		scr_debug_log(
			"CARDS",
			"COLLECTION",
			undefined,
			"CARD ADD FAILED | REASON: MISSING CARD NAME",
			"ERROR",
			"SCR_DECK_ADD_CARD"
		);

		return false;
	}

	//================//
	//VALIDATE LISTS//
	//================//
	if (
		!variable_global_exists("list_player_deck") ||
		!ds_exists(global.list_player_deck,ds_type_list)
	){

		scr_debug_log(
			"CARDS",
			"DECK",
			undefined,
			"CARD ADD FAILED" +
			" | CARD: " +
			string_upper(_stct_new_card._str_card_name) +
			" | REASON: DECK LIST INVALID",
			"ERROR",
			"SCR_DECK_ADD_CARD"
		);

		return false;
	}

	if (
		!variable_global_exists("list_player_library") ||
		!ds_exists(global.list_player_library,ds_type_list)
	){

		scr_debug_log(
			"CARDS",
			"LIBRARY",
			undefined,
			"CARD ADD FAILED" +
			" | CARD: " +
			string_upper(_stct_new_card._str_card_name) +
			" | REASON: LIBRARY LIST INVALID",
			"ERROR",
			"SCR_DECK_ADD_CARD"
		);

		return false;
	}

	//================//
	//CARD DATA//
	//================//
	var _str_card_name = string_upper(_stct_new_card._str_card_name);
	var _str_card_id = "";

	if (variable_struct_exists(_stct_new_card,"_str_card_id")){

		_str_card_id = _stct_new_card._str_card_id;
	}
	else{

		_str_card_id = string_upper(
			string_replace_all(
				_stct_new_card._str_card_name,
				" ",
				"_"
			)
		);
	}

	var _uid_card = -1;

	if (variable_struct_exists(_stct_new_card,"_uid_card")){
		_uid_card = _stct_new_card._uid_card;
	}

	var _str_rarity = "UNKNOWN";

	if (variable_struct_exists(_stct_new_card,"_str_card_rarity")){
		_str_rarity = string_upper(_stct_new_card._str_card_rarity);
	}

	var _val_mana_cost = 0;

	if (variable_struct_exists(_stct_new_card,"_val_card_mana_cost")){
		_val_mana_cost = _stct_new_card._val_card_mana_cost;
	}

	//================//
	//STORE COUNTS//
	//================//
	var _ct_deck_before = ds_list_size(global.list_player_deck);
	var _ct_library_before = ds_list_size(global.list_player_library);

	//======================//
	//ADD TO DECK OR LIBRARY//
	//======================//
	var _str_destination = "DECK";

	if (_ct_deck_before < 30){

		ds_list_add(
			global.list_player_deck,
			_stct_new_card
		);
	}
	else{

		ds_list_add(
			global.list_player_library,
			_stct_new_card
		);

		_str_destination = "LIBRARY";
	}

	//================//
	//UPDATE LOGBOOK//
	//================//
	if (
		variable_global_exists("map_logbook_cards") &&
		ds_exists(global.map_logbook_cards,ds_type_map)
	){

		scr_logbook_mark_card_obtained(
			_str_card_id
		);
	}

	//================//
	//DEBUG CARD ADD//
	//================//
	var _ct_deck_after = ds_list_size(global.list_player_deck);
	var _ct_library_after = ds_list_size(global.list_player_library);

	scr_debug_log(
		"CARDS",
		_str_destination,
		undefined,
		"CARD ACQUIRED" +
		" | CARD: " + _str_card_name +
		" | ID: " + string_upper(_str_card_id) +
		" | UID: " + string(_uid_card) +
		" | RARITY: " + _str_rarity +
		" | MANA: " + string(_val_mana_cost) +
		" | DESTINATION: " + _str_destination +
		" | DECK: " +
		string(_ct_deck_before) +
		" -> " +
		string(_ct_deck_after) +
		"/30" +
		" | LIBRARY: " +
		string(_ct_library_before) +
		" -> " +
		string(_ct_library_after),
		"INFO",
		"SCR_DECK_ADD_CARD"
	);

	return true;
}