//===============================================================================//
//
// STEP: OBJ_WORLD_EVENT_CONTROLLER
// FUNCTION: Observes room changes and performs one spawn-point validation after
//           each room entry. Phase I intentionally contains no event rolling,
//           timers, announcements, spawning, objectives, or battle callbacks.
//
//===============================================================================//

//================//
//REPAIR GLOBAL REF//
//================//
if (
	!variable_global_exists(
		"ref_world_event_controller"
	) ||
	global.ref_world_event_controller !=
	id
){
	global.ref_world_event_controller =
		id;
}

//================//
//ROOM CHANGE//
//================//
if (_rm_observed_room != room){

	_rm_previous_room =
		_rm_observed_room;

	_rm_observed_room =
		room;

	_ct_room_revision++;

	_flag_room_validation_pending =
		true;

	scr_debug_log(
		"WORLD_EVENT",
		"ROOM",
		self,
		"WORLD EVENT CONTROLLER ROOM CHANGE" +
		" | FROM: " +
		(
			_rm_previous_room == undefined
			? "UNDEFINED"
			: string_upper(
				room_get_name(
					_rm_previous_room
				)
			)
		) +
		" | TO: " +
		string_upper(
			room_get_name(
				_rm_observed_room
			)
		) +
		" | REVISION: " +
		string(
			_ct_room_revision
		),
		"INFO",
		"OBJ_WORLD_EVENT_CONTROLLER:STEP"
	);
}

//========================//
//VALIDATE ROOM ANCHORS//
//========================//
if (_flag_room_validation_pending){

	_flag_room_validation_pending =
		false;

	if (room != rm_battle){

		_stct_last_spawn_validation =
			scr_world_event_validate_spawn_points(
				room
			);

		scr_debug_log(
			"WORLD_EVENT",
			"SPAWN_POINT",
			self,
			"WORLD EVENT SPAWN VALIDATION" +
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
			" | TOTAL: " +
			string(
				_stct_last_spawn_validation
					._ct_total
			) +
			" | VALID: " +
			string(
				_stct_last_spawn_validation
					._ct_valid
			) +
			" | INVALID: " +
			string(
				_stct_last_spawn_validation
					._ct_invalid
			) +
			" | DUPLICATES: " +
			string(
				_stct_last_spawn_validation
					._ct_duplicates
			),
			"INFO",
			"OBJ_WORLD_EVENT_CONTROLLER:STEP"
		);
	}
}
