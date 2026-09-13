//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_CARD_OBTAINED
// FUNCTION: Marks a Card as obtained in the Card Logbook.
//           Also marks it as seen.
//           Increments seen/obtained counters and the Logbook revision.
//           Logs first discovery, first obtain state, and current owned count.
//
// ARGUMENTS: _str_card_id is the Card id to mark as obtained.
// RETURNS: True when the Logbook entry is updated; otherwise false.
//
//===============================================================================//

function scr_logbook_mark_card_obtained(_str_card_id){

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
			"CARD OBTAIN UPDATE FAILED" +
			" | ID: " + string_upper(_str_card_id) +
			" | REASON: CARD LOGBOOK MAP INVALID",
			"ERROR",
			"SCR_LOGBOOK_MARK_CARD_OBTAINED"
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
			"CARD OBTAIN UPDATE FAILED" +
			" | ID: " + string_upper(_str_card_id) +
			" | REASON: LOGBOOK ENTRY NOT FOUND",
			"ERROR",
			"SCR_LOGBOOK_MARK_CARD_OBTAINED"
		);

		return false;
	}

	//================//
	//GET ENTRY//
	//================//
	var _stct_entry = global.map_logbook_cards[? _str_card_id];

	var _flag_first_seen = !_stct_entry._flag_seen;
	var _flag_first_obtained = !_stct_entry._flag_obtained;

	var _ct_seen_before = _stct_entry._ct_seen;
	var _ct_obtained_before = _stct_entry._ct_obtained;

	//================//
	//UPDATE ENTRY//
	//================//
	_stct_entry._flag_seen = true;
	_stct_entry._flag_obtained = true;

	_stct_entry._ct_seen++;
	_stct_entry._ct_obtained++;

	global.map_logbook_cards[? _str_card_id] = _stct_entry;

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_logbook_revision++;

	//================//
	//GET OWNED COUNT//
	//================//
	var _ct_owned = scr_logbook_get_card_owned_count(
		_str_card_id
	);

	//================//
	//DEBUG UPDATE//
	//================//
	scr_debug_log(
		"LOGBOOK",
		"CARD",
		undefined,
		"CARD OBTAINED" +
		" | CARD: " +
		string_upper(_stct_entry._str_card_name) +
		" | ID: " +
		string_upper(_str_card_id) +
		" | FIRST DISCOVERY: " +
		(_flag_first_seen ? "YES" : "NO") +
		" | FIRST OBTAIN: " +
		(_flag_first_obtained ? "YES" : "NO") +
		" | SEEN: " +
		string(_ct_seen_before) +
		" -> " +
		string(_stct_entry._ct_seen) +
		" | OBTAINED: " +
		string(_ct_obtained_before) +
		" -> " +
		string(_stct_entry._ct_obtained) +
		" | OWNED: " +
		string(_ct_owned) +
		" | REVISION: " +
		string(global.ct_logbook_revision),
		"INFO",
		"SCR_LOGBOOK_MARK_CARD_OBTAINED"
	);

	return true;
}