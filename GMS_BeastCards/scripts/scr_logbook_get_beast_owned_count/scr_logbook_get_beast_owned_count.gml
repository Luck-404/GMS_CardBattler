//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_GET_BEAST_OWNED_COUNT
// FUNCTION: Returns the current owned count for a Beast id.
//           Counts matching Beasts in both the player party and ranch.
//           Does not modify logbook state.
//
// ARGUMENTS: _str_beast_id is the Beast id to count.
// RETURNS: Total number of matching owned Beasts.
//
//===============================================================================//

function scr_logbook_get_beast_owned_count(_str_beast_id){

	//================//
	//LOCAL METHODS//
	//================//

	//-------------------------------------------------------------------------------//
	// HSCR_LOGBOOK_COUNT_BEAST_IN_LIST
	// FUNCTION: Counts matching Beasts within a supplied DS list.
	//
	// ARGUMENTS: _list_beasts is the Beast list; _str_id is the Beast id to count.
	// RETURNS: Number of matching Beasts in the supplied list.
	//
	//-------------------------------------------------------------------------------//
	function hscr_logbook_count_beast_in_list(_list_beasts,_str_id){

		if (!ds_exists(_list_beasts,ds_type_list)){
			return 0;
		}

		var _ct_owned = 0;

		for (var _it_beast = 0; _it_beast < ds_list_size(_list_beasts); _it_beast++){

			var _stct_beast = ds_list_find_value(_list_beasts,_it_beast);

			if (_stct_beast == undefined){
				continue;
			}

			if (!variable_struct_exists(_stct_beast,"_str_beast_name")){
				continue;
			}

			if (_stct_beast._str_beast_name == _str_id){
				_ct_owned++;
			}
		}

		return _ct_owned;
	}

	//================//
	//COUNT OWNED BEASTS//
	//================//
	var _ct_party = hscr_logbook_count_beast_in_list(global.list_player_party,_str_beast_id);
	var _ct_ranch = hscr_logbook_count_beast_in_list(global.list_player_ranch,_str_beast_id);

	return _ct_party + _ct_ranch;
}