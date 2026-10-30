//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GET_BATTLE_CONTEXT
// FUNCTION: Returns the currently active persistent battle context.
//
// RETURNS: Active context struct or undefined.
//
//===============================================================================//

function scr_world_event_get_battle_context(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (
		!instance_exists(
			_ref_controller
		) ||
		!variable_instance_exists(
			_ref_controller,
			"_stct_battle_context"
		) ||
		!is_struct(
			_ref_controller
				._stct_battle_context
		) ||
		!_ref_controller
			._stct_battle_context
			._flag_active
	){
		return undefined;
	}

	return _ref_controller
		._stct_battle_context;
}
