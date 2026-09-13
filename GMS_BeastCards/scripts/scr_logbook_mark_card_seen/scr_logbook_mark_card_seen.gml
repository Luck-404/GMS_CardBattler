//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_CARD_SEEN
// FUNCTION: Marks a Card as seen in the Card Logbook.
//           Increments its seen counter and the Logbook revision.
//           Logs whether this was the Card's first discovery.
//
// ARGUMENTS: _str_card_id is the Card id to mark as seen.
// RETURNS: True when the Logbook entry is updated; otherwise false.
//
//===============================================================================//

function scr_logbook_mark_card_seen(_str_card_id){

	//================//
	//VALIDATE LOGBOOK//
	//================//
	if (
		!variable_global_exists("map_logbook_cards") ||
		!ds_exists(global.map_logbook_cards,ds_type_map)
	){

		scr_debug_log(
			"LOGBOOK",
			"CARD",
			undefined,
			"CARD SEEN UPDATE FAILED" +
			" | ID: " + string_upper(_str_card_id) +
			" | REASON: CARD LOGBOOK MAP INVALID",
			"ERROR",
			"SCR_LOGBOOK_MARK_CARD_SEEN"
		);

		return false;
	}

	//================//
	//VALIDATE ENTRY//
	//================//
	if (!ds_map_exists(global.map_logbook_cards,_str_card_id)){

		scr_debug_log(
			"LOGBOOK",
			"CARD",
			undefined,
			"CARD SEEN UPDATE FAILED" +
			" | ID: " + string_upper(_str_card_id) +
			" | REASON: LOGBOOK ENTRY NOT FOUND",
			"ERROR",
			"SCR_LOGBOOK_MARK_CARD_SEEN"
		);

		return false;
	}

	//================//
	//GET ENTRY//
	//================//
	var _stct_entry = global.map_logbook_cards[? _str_card_id];

	var _flag_first_seen = !_stct_entry._flag_seen;
	var _ct_seen_before = _stct_entry._ct_seen;

	//================//
	//UPDATE ENTRY//
	//================//
	_stct_entry._flag_seen = true;
	_stct_entry._ct_seen++;

	global.map_logbook_cards[? _str_card_id] = _stct_entry;

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_logbook_revision++;

	//================//
	//DEBUG UPDATE//
	//================//
	scr_debug_log(
		"LOGBOOK",
		"CARD",
		undefined,
		"CARD SEEN" +
		" | CARD: " +
		string_upper(_stct_entry._str_card_name) +
		" | ID: " +
		string_upper(_str_card_id) +
		" | FIRST DISCOVERY: " +
		(_flag_first_seen ? "YES" : "NO") +
		" | SEEN: " +
		string(_ct_seen_before) +
		" -> " +
		string(_stct_entry._ct_seen) +
		" | REVISION: " +
		string(global.ct_logbook_revision),
		"INFO",
		"SCR_LOGBOOK_MARK_CARD_SEEN"
	);

	return true;
}