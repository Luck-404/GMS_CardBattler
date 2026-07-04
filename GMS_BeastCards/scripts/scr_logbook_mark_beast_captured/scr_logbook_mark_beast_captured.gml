//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_BEAST_CAPTURED
// FUNCTION: Marks a beast as captured in the beast logbook.
//           Also marks the beast as seen.
//           Increments the captured counter and updates revision.
//
//===============================================================================//

function scr_logbook_mark_beast_captured(_str_beast_id){

	//—------------------------------------------------------------------------------//
	// VALIDATE ENTRY
	//—------------------------------------------------------------------------------//
	if (!ds_map_exists(global.map_logbook_beasts,_str_beast_id)){
		show_debug_message("LOGBOOK ERROR: Beast entry not found for captured id: " + string(_str_beast_id));
		return false;
	}

	//—------------------------------------------------------------------------------//
	// UPDATE ENTRY
	//—------------------------------------------------------------------------------//
	var _stct_entry = global.map_logbook_beasts[? _str_beast_id];

	_stct_entry._flag_seen = true;
	_stct_entry._flag_captured = true;

	_stct_entry._ct_seen++;
	_stct_entry._ct_captured++;

	global.map_logbook_beasts[? _str_beast_id] = _stct_entry;

	global.ct_logbook_revision++;

	return true;
}