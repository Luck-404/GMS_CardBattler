//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_PLAYER_MAX_MANA
// FUNCTION: Returns the player's battle Maximum Mana after persistent Party
//           Held Item team rules.
//
//           Base Maximum Mana: 3.
//           ARCANE CAPACITOR: +1 Maximum Mana.
//           Arcane Capacitor is Unique, but this helper still guards against
//           duplicate copies by applying the effect only once.
//
// ARGUMENTS: None.
// RETURNS: Player Maximum Mana for battle initialization.
//
//===============================================================================//

function scr_battle_get_player_max_mana(){

	var _val_max_mana = 3;
	var _flag_arcane_capacitor = false;

	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list)
	){
		return _val_max_mana;
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
			"HELD_ARCANE_CAPACITOR"
		){
			_flag_arcane_capacitor = true;
			break;
		}
	}

	if (_flag_arcane_capacitor){
		_val_max_mana++;
	}

	return _val_max_mana;
}