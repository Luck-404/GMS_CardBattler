//===============================================================================//
//
// SCRIPT: SCR_PARTY_ADD_BEAST
// FUNCTION: Adds a Beast struct to the player's Party when space is available.
//           Otherwise sends the Beast to the Ranch.
//           Marks the Beast as captured in the Logbook and logs its destination.
//
// ARGUMENTS: _stct_new_beast is the persistent Beast struct being added.
// RETURNS: True when the Beast is successfully added; otherwise false.
//
//===============================================================================//

function scr_party_add_beast(_stct_new_beast){

	//================//
	//VALIDATE BEAST//
	//================//
	if (!is_struct(_stct_new_beast)){

		scr_debug_log(
			"BEASTS",
			"PARTY",
			undefined,
			"FAILED TO ADD BEAST | REASON: INVALID BEAST STRUCT",
			"ERROR",
			"SCR_PARTY_ADD_BEAST"
		);

		return false;
	}

	if (!variable_struct_exists(_stct_new_beast,"_str_beast_name")){

		scr_debug_log(
			"BEASTS",
			"PARTY",
			undefined,
			"FAILED TO ADD BEAST | REASON: MISSING BEAST NAME",
			"ERROR",
			"SCR_PARTY_ADD_BEAST"
		);

		return false;
	}

	//================//
	//VALIDATE LISTS//
	//================//
	if (
		!variable_global_exists("list_player_party") ||
		!ds_exists(global.list_player_party,ds_type_list) ||
		!variable_global_exists("list_player_ranch") ||
		!ds_exists(global.list_player_ranch,ds_type_list)
	){

		scr_debug_log(
			"BEASTS",
			"PARTY",
			undefined,
			"FAILED TO ADD BEAST | BEAST: " +
			string_upper(_stct_new_beast._str_beast_name) +
			" | REASON: PARTY/RANCH LIST INVALID",
			"ERROR",
			"SCR_PARTY_ADD_BEAST"
		);

		return false;
	}

	//================//
	//GET BEAST DATA//
	//================//
	var _str_beast_name = string_upper(_stct_new_beast._str_beast_name);

	var _val_beast_level = 1;

	if (variable_struct_exists(_stct_new_beast,"_val_beast_level")){
		_val_beast_level = _stct_new_beast._val_beast_level;
	}

	var _uid_beast = -1;

	if (variable_struct_exists(_stct_new_beast,"_uid_beast")){
		_uid_beast = _stct_new_beast._uid_beast;
	}

	//================//
	//ADD BEAST//
	//================//
	var _str_destination = "RANCH";

	if (ds_list_size(global.list_player_party) < 5){

		ds_list_add(
			global.list_player_party,
			_stct_new_beast
		);

		_str_destination = "PARTY";
	}
	else{

		ds_list_add(
			global.list_player_ranch,
			_stct_new_beast
		);
	}

	//================//
	//UPDATE LOGBOOK//
	//================//
	if (
		variable_global_exists("map_logbook_beasts") &&
		ds_exists(global.map_logbook_beasts,ds_type_map)
	){
		scr_logbook_mark_beast_captured(_stct_new_beast._str_beast_name);
	}

	//================//
	//DEBUG ADDITION//
	//================//
	scr_debug_log(
		"BEASTS",
		_str_destination,
		undefined,
		_str_beast_name +
		" ADDED TO " +
		_str_destination +
		" | LEVEL: " +
		string(_val_beast_level) +
		" | UID: " +
		string(_uid_beast) +
		" | PARTY: " +
		string(ds_list_size(global.list_player_party)) +
		"/5" +
		" | RANCH: " +
		string(ds_list_size(global.list_player_ranch)),
		"INFO",
		"SCR_PARTY_ADD_BEAST"
	);

	return true;
}