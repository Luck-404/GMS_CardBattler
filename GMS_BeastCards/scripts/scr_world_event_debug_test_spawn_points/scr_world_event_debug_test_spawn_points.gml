//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_DEBUG_TEST_SPAWN_POINTS
// FUNCTION: Phase I diagnostic helper. Validates the current room, filters its
//           hand-placed World Event anchors, randomly selects requested anchors,
//           and logs only their stable logical IDs.
//
// ARGUMENTS: _str_category - GENERAL, MOB, TREASURE, MERCHANT, or ELITE.
//            _ct_requested - Number of unique points to select.
//            _ct_min_capacity - Required minimum capacity.
// RETURNS: Array of selected stable spawn-point ID strings.
//
//===============================================================================//

function scr_world_event_debug_test_spawn_points(
	_str_category="GENERAL",
	_ct_requested=1,
	_ct_min_capacity=1
){

	var _arr_selected_ids = [];

	var _stct_validation =
		scr_world_event_validate_spawn_points(
			room
		);

	var _arr_selected =
		scr_world_event_select_spawn_points(
			room,
			_str_category,
			_ct_requested,
			_ct_min_capacity
		);

	for (
		var _it_point = 0;
		_it_point <
			array_length(
				_arr_selected
			);
		_it_point++
	){

		var _ref_point =
			_arr_selected[
				_it_point
			];

		if (!instance_exists(_ref_point)){
			continue;
		}

		array_push(
			_arr_selected_ids,
			_ref_point
				._str_spawn_id
		);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"DEBUG",
		scr_world_event_get_controller(),
		"PHASE I SPAWN TEST" +
		" | ROOM: " +
		string_upper(
			room_get_name(
				room
			)
		) +
		" | ELIGIBLE: " +
		(
			scr_world_event_is_room_eligible(
				room
			)
			? "YES"
			: "NO"
		) +
		" | CATEGORY: " +
		string_upper(
			string(
				_str_category
			)
		) +
		" | TOTAL POINTS: " +
		string(
			_stct_validation._ct_total
		) +
		" | VALID: " +
		string(
			_stct_validation._ct_valid
		) +
		" | INVALID: " +
		string(
			_stct_validation._ct_invalid
		) +
		" | SELECTED: " +
		string(
			array_length(
				_arr_selected_ids
			)
		) +
		" | IDS: " +
		string(
			_arr_selected_ids
		),
		"INFO",
		"SCR_WORLD_EVENT_DEBUG_TEST_SPAWN_POINTS"
	);

	return _arr_selected_ids;
}
