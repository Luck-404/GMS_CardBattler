//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CLEAR_BATTLE_CONTEXT
// FUNCTION: Clears the current battle context without changing the active World
//           Event itself.
//
// ARGUMENTS: _flag_log - Emit debug entry.
// RETURNS: True when a controller exists.
//
//===============================================================================//

function scr_world_event_clear_battle_context(_flag_log=false){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	if (
		is_struct(
			_ref_controller
				._stct_active_world_event
		)
	){
		_ref_controller
			._stct_active_world_event
			._flag_event_battle_active =
			false;
	}

	_ref_controller._stct_battle_context =
		scr_world_event_create_empty_battle_context();

	if (_flag_log){

		scr_debug_log(
			"WORLD_EVENT",
			"BATTLE",
			_ref_controller,
			"WORLD EVENT BATTLE CONTEXT CLEARED",
			"INFO",
			"SCR_WORLD_EVENT_CLEAR_BATTLE_CONTEXT"
		);
	}

	return true;
}
