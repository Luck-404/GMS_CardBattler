//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_CARD_SEEN
// FUNCTION: Marks a card as seen in the card logbook.
//           Increments the seen counter.
//           Updates the logbook revision counter.
//
//===============================================================================//

function scr_logbook_mark_card_seen(_str_card_id){

	//—------------------------------------------------------------------------------//
	// VALIDATE ENTRY
	//—------------------------------------------------------------------------------//
	if (!ds_map_exists(global.map_logbook_cards,_str_card_id)){
		show_debug_message("LOGBOOK ERROR: Card entry not found for seen id: " + string(_str_card_id));
		return false;
	}

	//—------------------------------------------------------------------------------//
	// UPDATE ENTRY
	//—------------------------------------------------------------------------------//
	var _stct_entry = global.map_logbook_cards[? _str_card_id];

	_stct_entry._flag_seen = true;
	_stct_entry._ct_seen++;

	global.map_logbook_cards[? _str_card_id] = _stct_entry;

	global.ct_logbook_revision++;

	return true;
}