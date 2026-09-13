//===============================================================================//
//
// SCRIPT: SCR_LOGBOOK_MARK_BEAST_CAPTURED
// FUNCTION: Marks a Beast as captured in the Beast Logbook.
//           Also marks it as seen.
//           Increments seen/captured counters and the Logbook revision.
//           Logs first discovery and first capture state.
//
// ARGUMENTS: _str_beast_id is the Beast id to mark as captured.
// RETURNS: True when the Logbook entry is updated; otherwise false.
//
//===============================================================================//

function scr_logbook_mark_beast_captured(_str_beast_id){

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
			"BEAST CAPTURE UPDATE FAILED" +
			" | ID: " + string_upper(_str_beast_id) +
			" | REASON: BEAST LOGBOOK MAP INVALID",
			"ERROR",
			"SCR_LOGBOOK_MARK_BEAST_CAPTURED"
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
			"BEAST CAPTURE UPDATE FAILED" +
			" | ID: " + string_upper(_str_beast_id) +
			" | REASON: LOGBOOK ENTRY NOT FOUND",
			"ERROR",
			"SCR_LOGBOOK_MARK_BEAST_CAPTURED"
		);

		return false;
	}

	//================//
	//GET ENTRY//
	//================//
	var _stct_entry = global.map_logbook_beasts[? _str_beast_id];

	var _flag_first_seen = !_stct_entry._flag_seen;
	var _flag_first_capture = !_stct_entry._flag_captured;

	var _ct_seen_before = _stct_entry._ct_seen;
	var _ct_captured_before = _stct_entry._ct_captured;

	//================//
	//UPDATE ENTRY//
	//================//
	_stct_entry._flag_seen = true;
	_stct_entry._flag_captured = true;

	_stct_entry._ct_seen++;
	_stct_entry._ct_captured++;

	global.map_logbook_beasts[? _str_beast_id] = _stct_entry;

	//================//
	//UPDATE REVISION//
	//================//
	global.ct_logbook_revision++;

	//================//
	//GET OWNED COUNT//
	//================//
	var _ct_owned = scr_logbook_get_beast_owned_count(
		_str_beast_id
	);

	//================//
	//DEBUG UPDATE//
	//================//
	scr_debug_log(
		"LOGBOOK",
		"BEAST",
		undefined,
		"BEAST CAPTURED" +
		" | BEAST: " +
		string_upper(_stct_entry._str_beast_name) +
		" | ID: " +
		string_upper(_str_beast_id) +
		" | FIRST DISCOVERY: " +
		(_flag_first_seen ? "YES" : "NO") +
		" | FIRST CAPTURE: " +
		(_flag_first_capture ? "YES" : "NO") +
		" | SEEN: " +
		string(_ct_seen_before) +
		" -> " +
		string(_stct_entry._ct_seen) +
		" | CAPTURED: " +
		string(_ct_captured_before) +
		" -> " +
		string(_stct_entry._ct_captured) +
		" | OWNED: " +
		string(_ct_owned) +
		" | REVISION: " +
		string(global.ct_logbook_revision),
		"INFO",
		"SCR_LOGBOOK_MARK_BEAST_CAPTURED"
	);

	return true;
}