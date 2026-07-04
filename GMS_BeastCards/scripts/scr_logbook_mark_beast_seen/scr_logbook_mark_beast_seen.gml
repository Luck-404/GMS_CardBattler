//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_BEAST_SEEN
// FUNCTION: Marks a beast as seen in the beast logbook.
//           Increments the seen counter.
//           Updates the logbook revision counter.
//
//===============================================================================//

function scr_logbook_mark_beast_seen(_str_beast_id){

	//—------------------------------------------------------------------------------//
	// VALIDATE ENTRY
	//—------------------------------------------------------------------------------//
	if (!ds_map_exists(global.map_logbook_beasts,_str_beast_id)){
		show_debug_message("LOGBOOK ERROR: Beast entry not found for seen id: " + string(_str_beast_id));
		return false;
	}

	//—------------------------------------------------------------------------------//
	// UPDATE ENTRY
	//—------------------------------------------------------------------------------//
	var _stct_entry = global.map_logbook_beasts[? _str_beast_id];

	_stct_entry._flag_seen = true;
	_stct_entry._ct_seen++;

	global.map_logbook_beasts[? _str_beast_id] = _stct_entry;

	global.ct_logbook_revision++;

	return true;
}