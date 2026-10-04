//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES
// FUNCTION: Calculates player battle Card-flow rules from equipped persistent
//           Party Held Items.
//
//           Base rules:
//               Opening draw: 4
//               Turn draw:    2
//               Max hand:     4
//
//           FORGOTTEN MANUSCRIPT:
//               Unique. +1 maximum retained hand size.
//
//           ARCHMAGE'S FOCUS:
//               Unique. +1 begin-turn draw.
//
//           SEER'S LENS:
//               +2 opening-hand Cards per equipped copy.
//               Seer's Lens is not Unique and therefore stacks by holder.
//
// ARGUMENTS: None.
// RETURNS: Struct containing opening draw, turn draw, and maximum hand size.
//
//===============================================================================//

function scr_battle_get_player_card_flow_rules(){

	var _stct_rules = {
		_ct_opening_draw : 4,
		_ct_turn_draw : 2,
		_ct_hand_size : 4
	};

	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return _stct_rules;
	}

	var _flag_forgotten_manuscript = false;
	var _flag_archmages_focus = false;
	var _ct_seers_lens = 0;

	for (
		var _it_beast = 0;
		_it_beast < ds_list_size(global.list_player_party);
		_it_beast++
	){

		var _stct_beast =
			ds_list_find_value(
				global.list_player_party,
				_it_beast
			);

		if (!is_struct(_stct_beast)){
			continue;
		}

		var _stct_item =
			_stct_beast._stct_beast_held_item;

		if (
			!is_struct(_stct_item) ||
			_stct_item == "EMPTY"
		){
			continue;
		}

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

		switch (_stct_item._str_item_id){

			case "HELD_FORGOTTEN_MANUSCRIPT":
				_flag_forgotten_manuscript = true;
			break;

			case "HELD_ARCHMAGES_FOCUS":
				_flag_archmages_focus = true;
			break;

			case "HELD_SEERS_LENS":
				_ct_seers_lens++;
			break;
		}
	}

	if (_flag_forgotten_manuscript){
		_stct_rules._ct_hand_size++;
	}

	if (_flag_archmages_focus){
		_stct_rules._ct_turn_draw++;
	}

	if (_ct_seers_lens > 0){
		_stct_rules._ct_opening_draw +=
			_ct_seers_lens * 2;
	}

	scr_debug_log(
		"BATTLE",
		"CARD_FLOW",
		undefined,
		"CARD FLOW RULES" +
		" | OPENING DRAW: " + string(_stct_rules._ct_opening_draw) +
		" | TURN DRAW: " + string(_stct_rules._ct_turn_draw) +
		" | MAX HAND: " + string(_stct_rules._ct_hand_size) +
		" | FORGOTTEN MANUSCRIPT: " + (_flag_forgotten_manuscript ? "YES" : "NO") +
		" | ARCHMAGE'S FOCUS: " + (_flag_archmages_focus ? "YES" : "NO") +
		" | SEER'S LENS: " + string(_ct_seers_lens),
		"INIT",
		"SCR_BATTLE_GET_PLAYER_CARD_FLOW_RULES"
	);

	return _stct_rules;
}