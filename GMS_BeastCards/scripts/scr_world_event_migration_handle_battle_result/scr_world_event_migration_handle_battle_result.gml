//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_HANDLE_BATTLE_RESULT
// FUNCTION: Applies one resolved MIGRATION_POD battle context to persistent
//           Migration state.
//
//           WIN:
//           - pod permanently resolves;
//           - captured members are marked CAPTURED;
//           - all other pod members are marked DEFEATED.
//
//           LOSS:
//           - successful captures remain permanently removed;
//           - all non-captured members remain unresolved and reconstruct later.
//
// ARGUMENTS: _stct_context - Resolved Phase III battle context.
// RETURNS: True when the owning Migration pod was found and processed.
//
//===============================================================================//

function scr_world_event_migration_handle_battle_result(_stct_context){

	if (!is_struct(_stct_context)){
		return false;
	}

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
		_stct_world_event._uid_world_event !=
			_stct_context._uid_world_event ||
		_stct_world_event._str_event_id !=
			"MIGRATION"
	){
		return false;
	}

	var _stct_pod =
		scr_world_event_migration_get_pod(
			_stct_world_event,
			_stct_context
				._uid_world_event_pod
		);

	if (!is_struct(_stct_pod)){
		return false;
	}

	var _str_result =
		string_upper(
			string(
				_stct_context
					._str_result
			)
		);

	if (
		_str_result != "WIN" &&
		_str_result != "LOSS"
	){
		return false;
	}

	//================//
	//CAPTURED MEMBERS//
	//================//
	for (
		var _it_capture = 0;
		_it_capture <
			array_length(
				_stct_context
					._arr_captured_enemy_uids
			);
		_it_capture++
	){

		var _uid_captured_beast =
			_stct_context
				._arr_captured_enemy_uids[
					_it_capture
				];

		var _stct_capture_record =
			scr_world_event_migration_get_entity_by_beast_uid(
				_stct_world_event,
				_uid_captured_beast
			);

		if (
			!is_struct(
				_stct_capture_record
			) ||
			!is_struct(
				_stct_capture_record
					._stct_payload
			) ||
			_stct_capture_record
				._stct_payload
				._uid_migration_pod !=
			_stct_pod
				._uid_pod
		){
			continue;
		}

		_stct_capture_record._flag_resolved = true;
		_stct_capture_record._flag_claimed = true;
		_stct_capture_record._flag_removed = true;
		_stct_capture_record._str_entity_state = "CAPTURED";
	}

	//================//
	//WIN RESOLVES POD//
	//================//
	if (_str_result == "WIN"){

		for (
			var _it_member = 0;
			_it_member <
				array_length(
					_stct_pod
						._arr_member_entity_uids
				);
			_it_member++
		){

			var _stct_record =
				scr_world_event_entity_record_get(
					_stct_world_event,
					_stct_pod
						._arr_member_entity_uids[
							_it_member
						]
				);

			if (!is_struct(_stct_record)){
				continue;
			}

			if (!_stct_record._flag_resolved){

				_stct_record._flag_resolved = true;
				_stct_record._flag_removed = true;
				_stct_record._str_entity_state = "DEFEATED";
			}
		}

		_stct_pod._flag_resolved = true;
		_stct_pod._str_state = "DEFEATED";
	}

	// LOSS intentionally keeps every non-captured member unresolved.
	else{

		_stct_pod._flag_resolved = false;
		_stct_pod._str_state = "UNRESOLVED";
	}

	_stct_world_event._flag_room_initialized =
		false;

	scr_world_event_migration_refresh_progress(
		true
	);

	var _ct_pods_remaining = 0;

	if (
		is_struct(
			_stct_world_event
				._stct_payload
		) &&
		variable_struct_exists(
			_stct_world_event
				._stct_payload,
			"_ct_migration_pods_remaining"
		)
	){
		_ct_pods_remaining =
			_stct_world_event
				._stct_payload
				._ct_migration_pods_remaining;
	}

	scr_debug_log(
		"WORLD_EVENT",
		"MIGRATION",
		_ref_controller,
		"MIGRATION POD RESULT" +
		" | EVENT UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | POD UID: " +
		string(
			_stct_pod
				._uid_pod
		) +
		" | RESULT: " +
		_str_result +
		" | CAPTURES: " +
		string(
			array_length(
				_stct_context
					._arr_captured_enemy_uids
			)
		) +
		" | PODS REMAINING: " +
		string(
			_ct_pods_remaining
		),
		"INFO",
		"SCR_WORLD_EVENT_MIGRATION_HANDLE_BATTLE_RESULT"
	);

	return true;
}
