//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES
// FUNCTION: Calculates player battle Card-flow rules.
//           Reads equipped Held Items from the active Party.
//           Forgotten Manuscript increases maximum retained hand size by 1.
//           Archmage's Focus increases begin-turn draw amount by 1.
//           Unique Card-flow effects cannot stack.
//
// ARGUMENTS: None.
// RETURNS: Struct containing opening draw, turn draw, and maximum hand size.
//
//===============================================================================//

function scr_battle_get_player_card_flow_rules(){

	//================//
	//DEFAULT RULES//
	//================//
	var _stct_rules = {
		_ct_opening_draw : 4,
		_ct_turn_draw : 2,
		_ct_hand_size : 4
	};

	//----------------//
	//VALIDATE PARTY//
	//----------------//
	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return _stct_rules;
	}

	//================//
	//ITEM FLAGS//
	//================//
	var _flag_forgotten_manuscript = false;
	var _flag_archmages_focus = false;

	//================//
	//CHECK PARTY//
	//================//
	for (var _it_beast = 0; _it_beast < ds_list_size(global.list_player_party); _it_beast++){

		var _stct_beast = ds_list_find_value(global.list_player_party,_it_beast);

		if (!is_struct(_stct_beast)){
			continue;
		}

		var _stct_item = _stct_beast._stct_beast_held_item;

		if (
			!is_struct(_stct_item) ||
			_stct_item == "EMPTY"
		){
			continue;
		}

		//================//
	//DEBUG HELD ITEM//
	//================//
		scr_debug_log(
			"BATTLE",
			"CARD_FLOW",
			undefined,
			"HELD ITEM FOUND" +
			" | PARTY INDEX: " + string(_it_beast) +
			" | BEAST: " + string_upper(_stct_beast._str_beast_name) +
			" | ITEM: " + string_upper(_stct_item._str_item_name) +
			" | ID: " + string_upper(_stct_item._str_item_id),
			"INIT",
			"SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES"
		);

		//================//
	//CHECK ITEM ID//
	//================//
		switch(_stct_item._str_item_id){

			case "HELD_FORGOTTEN_MANUSCRIPT":
				_flag_forgotten_manuscript = true;
			break;

			case "HELD_ARCHMAGES_FOCUS":
				_flag_archmages_focus = true;
			break;
		}
	}

	//========================//
	//FORGOTTEN MANUSCRIPT//
	//========================//
	if (_flag_forgotten_manuscript){
		_stct_rules._ct_hand_size++;
	}

	//==================//
	//ARCHMAGE'S FOCUS//
	//==================//
	if (_flag_archmages_focus){
		_stct_rules._ct_turn_draw++;
	}

	//================//
	//DEBUG RESULT//
	//================//
	scr_debug_log(
		"BATTLE",
		"CARD_FLOW",
		undefined,
		"CARD FLOW RULES" +
		" | OPENING DRAW: " + string(_stct_rules._ct_opening_draw) +
		" | TURN DRAW: " + string(_stct_rules._ct_turn_draw) +
		" | MAX HAND: " + string(_stct_rules._ct_hand_size) +
		" | FORGOTTEN MANUSCRIPT: " + (_flag_forgotten_manuscript ? "YES" : "NO") +
		" | ARCHMAGE'S FOCUS: " + (_flag_archmages_focus ? "YES" : "NO"),
		"INIT",
		"SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES"
	);

	return _stct_rules;
}