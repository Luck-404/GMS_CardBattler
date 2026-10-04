//===============================================================================//
//
// SCRIPT: SCR_PARTY_SWAP_BEASTS
// FUNCTION: Swaps two Beasts in the player's persistent Party order.
//
//           Invalid, identical, or out-of-range Party slots do nothing.
//
// ARGUMENTS: _val_slot_a - First zero-based Party slot.
//            _val_slot_b - Second zero-based Party slot.
//            _str_origin - Optional debug caller.
// RETURNS: True when the Party order changed.
//
//===============================================================================//

function scr_party_swap_beasts(_val_slot_a,_val_slot_b,_str_origin="SCR_PARTY_SWAP_BEASTS"){

	#region VALIDATION

	//================//
	//VALIDATE PARTY//
	//================//
	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return false;
	}

	if (!is_real(_val_slot_a) || !is_real(_val_slot_b)){
		return false;
	}

	_val_slot_a = floor(_val_slot_a);
	_val_slot_b = floor(_val_slot_b);

	var _ct_party = ds_list_size(global.list_player_party);

	//================//
	//VALIDATE SLOTS//
	//================//
	if (
		_val_slot_a < 0 ||
		_val_slot_a >= _ct_party ||
		_val_slot_b < 0 ||
		_val_slot_b >= _ct_party ||
		_val_slot_a == _val_slot_b
	){
		return false;
	}

	var _stct_beast_a = ds_list_find_value(global.list_player_party,_val_slot_a);
	var _stct_beast_b = ds_list_find_value(global.list_player_party,_val_slot_b);

	if (!is_struct(_stct_beast_a) || !is_struct(_stct_beast_b)){
		return false;
	}

	#endregion

	#region SWAP

	//================//
	//SWAP PARTY SLOTS//
	//================//
	ds_list_replace(global.list_player_party,_val_slot_a,_stct_beast_b);
	ds_list_replace(global.list_player_party,_val_slot_b,_stct_beast_a);

	#endregion

	#region DEBUG

	scr_debug_log(
		"BEASTS",
		"PARTY",
		_stct_beast_a,
		"PARTY REORDERED" +
		" | BEAST: " + string_upper(_stct_beast_a._str_beast_name) +
		" | POSITION: " + string(_val_slot_a + 1) +
		" -> " + string(_val_slot_b + 1) +
		" | SWAPPED WITH: " + string_upper(_stct_beast_b._str_beast_name),
		"INFO",
		_str_origin
	);

	#endregion

	return true;
}
