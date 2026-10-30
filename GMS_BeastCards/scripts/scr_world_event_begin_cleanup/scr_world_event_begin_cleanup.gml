//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_BEGIN_CLEANUP
// FUNCTION: Moves an EXPIRED or completed-grace World Event into final CLEANUP.
//           Event-owned instance destruction is intentionally deferred to later
//           phases when those objects exist.
//
// RETURNS: True when CLEANUP state is entered.
//
//===============================================================================//

function scr_world_event_begin_cleanup(){

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
		)
	){
		return false;
	}

	if (
		_stct_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.EXPIRED &&
		_stct_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.COMPLETED
	){
		return false;
	}

	_stct_world_event
		._state_world_event =
		ENUM_WORLD_EVENT_STATE.CLEANUP;

	_stct_world_event
		._val_cleanup_time_remaining =
		0;

	scr_debug_log(
		"WORLD_EVENT",
		"STATE",
		_ref_controller,
		"WORLD EVENT ENTERED CLEANUP" +
		" | UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | EVENT: " +
		_stct_world_event
			._str_event_id,
		"INFO",
		"SCR_WORLD_EVENT_BEGIN_CLEANUP"
	);

	return true;
}
