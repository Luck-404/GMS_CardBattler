//===============================================================================//
//
// SCRIPT: SCR_DECK_GET_MAX_SIZE
// FUNCTION: Returns the player's current persistent maximum Deck Size.
//
//           Base Deck Size: 30.
//           EXPANDED GRIMOIRE: +5.
//           Expanded Grimoire is Unique, so its bonus is applied at most once.
//
//           All acquisition and Deck/Library GUI capacity checks should call
//           this helper instead of hard-coding 30.
//
// ARGUMENTS: None.
// RETURNS: Current maximum Deck Size.
//
//===============================================================================//

function scr_deck_get_max_size(){

	var _ct_deck_max = 30;
	var _flag_expanded_grimoire = false;

	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return _ct_deck_max;
	}

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

		if (
			_stct_item._str_item_id ==
			"HELD_EXPANDED_GRIMOIRE"
		){
			_flag_expanded_grimoire = true;
			break;
		}
	}

	if (_flag_expanded_grimoire){
		_ct_deck_max += 5;
	}

	return _ct_deck_max;
}