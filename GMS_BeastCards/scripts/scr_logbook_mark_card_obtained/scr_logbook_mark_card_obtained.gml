//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_CARD_OBTAINED
// FUNCTION: Marks a card as obtained in the card logbook.
//           Also marks the card as seen.
//           Increments the obtained counter and updates revision.
//
//===============================================================================//

function scr_logbook_mark_card_obtained(_str_card_id){

	//—------------------------------------------------------------------------------//
	// VALIDATE ENTRY
	//—------------------------------------------------------------------------------//
	if (!ds_map_exists(global.map_logbook_cards,_str_card_id)){
		show_debug_message("LOGBOOK ERROR: Card entry not found for obtained id: " + string(_str_card_id));
		return false;
	}

	//—------------------------------------------------------------------------------//
	// UPDATE ENTRY
	//—------------------------------------------------------------------------------//
	var _stct_entry = global.map_logbook_cards[? _str_card_id];

	_stct_entry._flag_seen = true;
	_stct_entry._flag_obtained = true;

	_stct_entry._ct_seen++;
	_stct_entry._ct_obtained++;

	global.map_logbook_cards[? _str_card_id] = _stct_entry;

	global.ct_logbook_revision++;

	return true;
}