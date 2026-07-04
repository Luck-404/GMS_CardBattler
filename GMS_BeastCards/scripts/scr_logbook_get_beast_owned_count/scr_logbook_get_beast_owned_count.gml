//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_GET_BEAST_OWNED_COUNT
// FUNCTION: Returns the current owned count for a beast id.
//           Counts matching beasts in both player party and player ranch.
//           Does not modify logbook state.
//
//===============================================================================//

function scr_logbook_get_beast_owned_count(_str_beast_id){

	//—------------------------------------------------------------------------------//
	// LOCAL HELPER: COUNT BEASTS IN LIST
	//—------------------------------------------------------------------------------//
	function hscr_count_beast_in_list(_list_beasts,_str_id){

		var _ct_owned = 0;

		if (!ds_exists(_list_beasts,ds_type_list)){
			return 0;
		}

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

	//—------------------------------------------------------------------------------//
	// COUNT PARTY + RANCH
	//—------------------------------------------------------------------------------//
	var _ct_party = hscr_count_beast_in_list(global.list_player_party,_str_beast_id);
	var _ct_ranch = hscr_count_beast_in_list(global.list_player_ranch,_str_beast_id);

	return _ct_party + _ct_ranch;
}