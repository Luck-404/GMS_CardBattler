//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SET_BATTLE_ROLL_SUPPRESSION
// FUNCTION: Arms or clears suppression for the next battle-completion World Event
//           roll. Phase III exact/event battles can use this without modifying
//           the post-battle result pane again.
//
// ARGUMENTS: _flag_suppress - Requested suppression state.
// RETURNS: True when a controller exists.
//
//===============================================================================//

function scr_world_event_set_battle_roll_suppression(_flag_suppress=true){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	_ref_controller
		._flag_suppress_next_battle_roll =
		_flag_suppress;

	return true;
}
