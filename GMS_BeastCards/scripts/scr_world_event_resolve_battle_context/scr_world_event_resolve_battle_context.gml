//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RESOLVE_BATTLE_CONTEXT
// FUNCTION: Resolves the active exact/scripted battle context when the battle
//           result pane is confirmed. World Event battles arm the existing
//           Phase II post-battle roll suppression before registration occurs.
//
// ARGUMENTS: _str_result - WIN or LOSS.
// RETURNS: True when an active context was resolved.
//
//===============================================================================//

function scr_world_event_resolve_battle_context(_str_result){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	if (
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
		return false;
	}

	_str_result =
		string_upper(
			string(
				_str_result
			)
		);

	if (
		_str_result != "WIN" &&
		_str_result != "LOSS"
	){
		return false;
	}

	var _stct_context =
		_ref_controller
			._stct_battle_context;

	_stct_context._str_result =
		_str_result;

	_stct_context._flag_result_resolved =
		true;

	// Preserve the completed context for debugging and future event-specific
	// inspection even after the active battle context is cleared.
	_ref_controller._stct_last_battle_context =
		_stct_context;

	var _flag_handled =
		scr_world_event_handle_battle_result(
			_stct_context
		);

	// World Event/scripted contexts may explicitly suppress the normal 1/50 roll.
	// This is armed immediately before Phase II's registration helper runs.
	if (
		_stct_context
			._flag_suppress_world_event_roll
	){
		scr_world_event_set_battle_roll_suppression(
			true
		);
	}

	_ref_controller._stct_battle_context =
		scr_world_event_create_empty_battle_context();

	return _flag_handled;
}
