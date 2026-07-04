//===============================================================================//
//
// SCRIPT: SCR_ADD_BEAST_TO_PARTY
// FUNCTION: Adds a beast struct to the player party if there is room.
//           Adds the beast struct to the player ranch if the party is full.
//           Marks the beast as captured in the logbook.
//
//===============================================================================//

function scr_add_beast_to_party(_stct_new_beast){

	//—------------------------------------------------------------------------------//
	// VALIDATE BEAST
	//—------------------------------------------------------------------------------//
	if (_stct_new_beast == undefined){
		show_debug_message("BEAST ERROR: Tried to add undefined beast to party.");
		return false;
	}

	if (!variable_struct_exists(_stct_new_beast,"_str_beast_name")){
		show_debug_message("BEAST ERROR: Tried to add beast with no _str_beast_name.");
		return false;
	}

	//—------------------------------------------------------------------------------//
	// ADD TO PARTY OR RANCH
	//—------------------------------------------------------------------------------//
	if (ds_list_size(global.list_player_party) < 5){
		ds_list_add(global.list_player_party,_stct_new_beast);
	}
	else{
		ds_list_add(global.list_player_ranch,_stct_new_beast);
	}

	//—------------------------------------------------------------------------------//
	// UPDATE LOGBOOK
	//—------------------------------------------------------------------------------//
	if (variable_global_exists("map_logbook_beasts")){
		scr_logbook_mark_beast_captured(_stct_new_beast._str_beast_name);
	}

	return true;
}