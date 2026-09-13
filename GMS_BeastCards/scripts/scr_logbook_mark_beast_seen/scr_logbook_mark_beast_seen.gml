//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_BEAST_SEEN
// FUNCTION: Marks a Beast as seen in the Beast Logbook.
//           Increments its seen counter and the Logbook revision.
//           Logs whether this was the Beast's first discovery.
//
// ARGUMENTS: _str_beast_id is the Beast id to mark as seen.
// RETURNS: True when the Logbook entry is updated; otherwise false.
//
//===============================================================================//

function scr_logbook_mark_beast_seen(_str_beast_id){

	//================//
	//VALIDATE LOGBOOK//
	//================//
	if (
		!variable_global_exists("map_logbook_beasts") ||
		!ds_exists(global.map_logbook_beasts,ds_type_map)
	){

		scr_debug_log(
			"LOGBOOK",
			"BEAST",
			undefined,
			"BEAST SEEN UPDATE FAILED" +
			" | ID: " + string_upper(_str_beast_id) +
			" | REASON: BEAST LOGBOOK MAP INVALID",
			"ERROR",
			"SCR_LOGBOOK_MARK_BEAST_SEEN"
		);

		return false;
	}

	//================//
	//VALIDATE ENTRY//
	//================//
	if (!ds_map_exists(global.map_logbook_beasts,_str_beast_id)){

		scr_debug_log(
			"LOGBOOK",
			"BEAST",
			undefined,
			"BEAST SEEN UPDATE FAILED" +
			" | ID: " + string_upper(_str_beast_id) +
			" | REASON: LOGBOOK ENTRY NOT FOUND",
			"ERROR",
			"SCR_LOGBOOK_MARK_BEAST_SEEN"
		);

		return false;
	}

	//================//
	//GET ENTRY//
	//================//
	var _stct_entry = global.map_logbook_beasts[? _str_beast_id];

	var _flag_first_seen = !_stct_entry._flag_seen;
	var _ct_seen_before = _stct_entry._ct_seen;

	//================//
	//UPDATE ENTRY//
	//================//
	_stct_entry._flag_seen = true;
	_stct_entry._ct_seen++;

	global.map_logbook_beasts[? _str_beast_id] = _stct_entry;

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_logbook_revision++;

	//================//
	//DEBUG UPDATE//
	//================//
	scr_debug_log(
		"LOGBOOK",
		"BEAST",
		undefined,
		"BEAST SEEN" +
		" | BEAST: " +
		string_upper(_stct_entry._str_beast_name) +
		" | ID: " +
		string_upper(_str_beast_id) +
		" | FIRST DISCOVERY: " +
		(_flag_first_seen ? "YES" : "NO") +
		" | SEEN: " +
		string(_ct_seen_before) +
		" -> " +
		string(_stct_entry._ct_seen) +
		" | REVISION: " +
		string(global.ct_logbook_revision),
		"INFO",
		"SCR_LOGBOOK_MARK_BEAST_SEEN"
	);

	return true;
}