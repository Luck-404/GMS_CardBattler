//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_EXPIRE
// FUNCTION: Marks the current ANNOUNCED or ACTIVE World Event expired.
//           Phase II has no spawned event content to remove; CLEANUP handles the
//           final state reset on the following controller steps.
//
// ARGUMENTS: _str_reason - Player/debug-readable expiry reason.
// RETURNS: True when the event changes to EXPIRED.
//
//===============================================================================//

function scr_world_event_expire(_str_reason="THE EVENT HAS ENDED"){

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
		(
			_stct_world_event
				._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ANNOUNCED &&
			_stct_world_event
				._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE
		)
	){
		return false;
	}

	_stct_world_event
		._state_world_event =
		ENUM_WORLD_EVENT_STATE.EXPIRED;

	_stct_world_event
		._val_announcement_time_remaining =
		0;

	_stct_world_event
		._val_active_time_remaining =
		0;

	_stct_world_event
		._val_cleanup_time_remaining =
		0;

	scr_world_event_show_banner(
		"WORLD EVENT EXPIRED",
		_stct_world_event
			._str_display_name,
		string_upper(
			string(
				_str_reason
			)
		)
	);

	scr_debug_log(
		"WORLD_EVENT",
		"STATE",
		_ref_controller,
		"WORLD EVENT EXPIRED" +
		" | UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | EVENT: " +
		_stct_world_event
			._str_event_id +
		" | REASON: " +
		string_upper(
			string(
				_str_reason
			)
		),
		"INFO",
		"SCR_WORLD_EVENT_EXPIRE"
	);

	return true;
}
