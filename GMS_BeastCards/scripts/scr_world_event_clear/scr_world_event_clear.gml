//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CLEAR
// FUNCTION: Resets persistent World Event state to the canonical empty record.
//           Phase I clears controller data only; later phases add owned-instance
//           cleanup after event objects actually exist.
//
// ARGUMENTS: _flag_log - Whether to emit a debug reset entry.
// RETURNS: True when controller state was reset.
//
//===============================================================================//

function scr_world_event_clear(_flag_log=true){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	_ref_controller._stct_active_world_event =
		scr_world_event_create_empty();

	if (_flag_log){

		scr_debug_log(
			"WORLD_EVENT",
			"STATE",
			_ref_controller,
			"WORLD EVENT STATE CLEARED",
			"INFO",
			"SCR_WORLD_EVENT_CLEAR"
		);
	}

	return true;
}
