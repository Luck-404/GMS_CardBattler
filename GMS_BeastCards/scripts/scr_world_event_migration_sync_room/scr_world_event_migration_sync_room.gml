//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_SYNC_ROOM
// FUNCTION: Generates Migration data once, then reconstructs all unresolved pod
//           members whenever the target room is entered on a new room revision.
//
// RETURNS: True when current-room Migration state is valid/synchronized.
//
//===============================================================================//

function scr_world_event_migration_sync_room(){

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
		_stct_world_event._str_event_id !=
			"MIGRATION" ||
		_stct_world_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE ||
		room !=
			_stct_world_event._rm_target
	){
		return false;
	}

	if (_stct_world_event._flag_event_battle_active){
		return true;
	}

	if (
		!scr_world_event_migration_generate()
	){
		return false;
	}

	var _stct_payload =
		_stct_world_event
			._stct_payload;

	// Persistent progression may have completed while the player was in battle.
	scr_world_event_migration_refresh_progress(
		true
	);

	if (
		_stct_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.ACTIVE
	){
		return true;
	}

	if (
		variable_struct_exists(
			_stct_payload,
			"_ct_last_spawn_room_revision"
		) &&
		_stct_payload._ct_last_spawn_room_revision ==
			_ref_controller._ct_room_revision &&
		_stct_world_event._flag_room_initialized
	){
		return true;
	}

	// Clear same-event room instances before reconstruction to prevent duplicate
	// pods if this sync is manually retriggered during development.
	scr_world_event_cleanup_room_instances(
		_stct_world_event
			._uid_world_event
	);

	var _ct_members_spawned = 0;
	var _ct_pods_spawned = 0;

	var _arr_pods =
		_stct_payload
			._arr_migration_pods;

	for (
		var _it_pod = 0;
		_it_pod <
			array_length(
				_arr_pods
			);
		_it_pod++
	){

		var _stct_pod =
			_arr_pods[
				_it_pod
			];

		if (
			!is_struct(
				_stct_pod
			) ||
			_stct_pod._flag_resolved
		){
			continue;
		}

		var _arr_roster =
			scr_world_event_migration_get_pod_roster(
				_stct_world_event,
				_stct_pod
			);

		if (
			array_length(
				_arr_roster
			) <=
			0
		){

			_stct_pod._flag_resolved = true;
			_stct_pod._str_state = "RESOLVED";
			continue;
		}

		var _ct_this_pod_spawned = 0;

		for (
			var _it_member = 0;
			_it_member <
				array_length(
					_stct_pod
						._arr_member_entity_uids
				);
			_it_member++
		){

			var _ref_member =
				scr_world_event_migration_spawn_member(
					_stct_world_event,
					_stct_pod,
					_it_member,
					_arr_roster
				);

			if (instance_exists(_ref_member)){
				_ct_members_spawned++;
				_ct_this_pod_spawned++;
			}
		}

		if (_ct_this_pod_spawned > 0){
			_ct_pods_spawned++;
		}
	}

	_stct_payload._ct_last_spawn_room_revision =
		_ref_controller._ct_room_revision;

	_stct_world_event._flag_room_initialized =
		true;

	scr_world_event_migration_refresh_progress(
		true
	);

	scr_debug_log(
		"WORLD_EVENT",
		"MIGRATION",
		_ref_controller,
		"MIGRATION ROOM SYNCHRONIZED" +
		" | EVENT UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | ROOM: " +
		_stct_world_event
			._str_target_room_name +
		" | SPECIES: " +
		_stct_payload
			._str_migration_species +
		" | PODS SPAWNED: " +
		string(
			_ct_pods_spawned
		) +
		" | MEMBERS SPAWNED: " +
		string(
			_ct_members_spawned
		) +
		" | PODS REMAINING: " +
		string(
			_stct_payload
				._ct_migration_pods_remaining
		),
		"INFO",
		"SCR_WORLD_EVENT_MIGRATION_SYNC_ROOM"
	);

	return true;
}
