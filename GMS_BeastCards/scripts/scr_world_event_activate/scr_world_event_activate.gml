//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ACTIVATE
// FUNCTION: Converts the current ANNOUNCED event to ACTIVE when the player first
//           reaches its target room. Event-specific room content is introduced
//           by later phases.
//
// ARGUMENTS: _flag_show_banner - Whether to show a separate ACTIVE banner.
// RETURNS: True when the state changes to ACTIVE.
//
//===============================================================================//

function scr_world_event_activate(_flag_show_banner=true){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_world_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(
			_stct_world_event
		) ||
		_stct_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.ANNOUNCED
	){
		return false;
	}

	if (
		room !=
		_stct_world_event
			._rm_target
	){
		return false;
	}

	_stct_world_event
		._state_world_event =
		ENUM_WORLD_EVENT_STATE.ACTIVE;

	_stct_world_event
		._val_announcement_time_remaining =
		0;

	_stct_world_event
		._val_active_time_remaining =
		_ref_controller
			._val_active_duration_seconds;

	if (_flag_show_banner){

		scr_world_event_show_banner(
			"WORLD EVENT ACTIVE — " +
				_stct_world_event
					._str_display_name,
			_stct_world_event
				._str_target_room_name,
			scr_world_event_format_time(
				_stct_world_event
					._val_active_time_remaining
			) +
				" REMAINING"
		);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"STATE",
		_ref_controller,
		"WORLD EVENT ACTIVATED" +
		" | UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | EVENT: " +
		_stct_world_event
			._str_event_id +
		" | ROOM: " +
		_stct_world_event
			._str_target_room_name +
		" | ACTIVE TIMER: " +
		string(
			_stct_world_event
				._val_active_time_remaining
		) +
		" SEC",
		"INFO",
		"SCR_WORLD_EVENT_ACTIVATE"
	);

	return true;
}
