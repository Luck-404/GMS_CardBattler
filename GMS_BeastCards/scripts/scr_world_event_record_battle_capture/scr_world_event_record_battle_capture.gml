//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RECORD_BATTLE_CAPTURE
// FUNCTION: Records a captured exact-roster Beast UID on the active battle
//           context. Event-specific capture rules can consume this list later.
//
//           No existing Prism script is modified in Phase III because no World
//           Event type currently spawns a capturable event encounter yet.
//
// ARGUMENTS: _uid_beast - Captured enemy Beast UID.
// RETURNS: True when the UID is recorded or was already present.
//
//===============================================================================//

function scr_world_event_record_battle_capture(_uid_beast){

	var _stct_context =
		scr_world_event_get_battle_context();

	if (!is_struct(_stct_context)){
		return false;
	}

	if (!is_real(_uid_beast)){
		return false;
	}

	for (
		var _it_capture = 0;
		_it_capture <
			array_length(
				_stct_context
					._arr_captured_enemy_uids
			);
		_it_capture++
	){

		if (
			_stct_context
				._arr_captured_enemy_uids[
					_it_capture
				] ==
			_uid_beast
		){
			return true;
		}
	}

	array_push(
		_stct_context
			._arr_captured_enemy_uids,
		_uid_beast
	);

	return true;
}
