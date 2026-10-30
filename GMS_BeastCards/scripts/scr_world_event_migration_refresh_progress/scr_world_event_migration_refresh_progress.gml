//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_REFRESH_PROGRESS
// FUNCTION: Recalculates unresolved Migration members/pods from persistent entity
//           records and completes the World Event when no pods remain.
//
// ARGUMENTS: _flag_allow_complete - Whether zero remaining pods may complete event.
// RETURNS: True when Migration state was refreshed.
//
//===============================================================================//

function scr_world_event_migration_refresh_progress(_flag_allow_complete=true){

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
		_stct_world_event
			._str_event_id !=
		"MIGRATION" ||
		!is_struct(
			_stct_world_event
				._stct_payload
		) ||
		!variable_struct_exists(
			_stct_world_event
				._stct_payload,
			"_arr_migration_pods"
		) ||
		!is_array(
			_stct_world_event
				._stct_payload
				._arr_migration_pods
		)
	){
		return false;
	}

	var _stct_payload =
		_stct_world_event
			._stct_payload;

	var _arr_pods =
		_stct_payload
			._arr_migration_pods;

	var _ct_pods_remaining = 0;
	var _ct_members_remaining = 0;

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

		if (!is_struct(_stct_pod)){
			continue;
		}

		var _ct_pod_members_remaining = 0;

		if (
			is_array(
				_stct_pod
					._arr_member_entity_uids
			)
		){

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

				if (
					is_struct(
						_stct_record
					) &&
					!_stct_record._flag_resolved
				){
					_ct_pod_members_remaining++;
				}
			}
		}

		if (_ct_pod_members_remaining <= 0){

			_stct_pod._flag_resolved = true;

			if (_stct_pod._str_state == "UNRESOLVED"){
				_stct_pod._str_state = "RESOLVED";
			}
		}

		if (!_stct_pod._flag_resolved){

			_ct_pods_remaining++;
			_ct_members_remaining +=
				_ct_pod_members_remaining;
		}
	}

	_stct_payload._ct_migration_pods_remaining =
		_ct_pods_remaining;

	_stct_payload._ct_migration_population_remaining =
		_ct_members_remaining;

	_stct_world_event._ct_goal =
		array_length(
			_arr_pods
		);

	_stct_world_event._ct_progress =
		_stct_world_event._ct_goal -
		_ct_pods_remaining;

	if (
		_flag_allow_complete &&
		_ct_pods_remaining <= 0 &&
		_stct_world_event
			._state_world_event ==
		ENUM_WORLD_EVENT_STATE.ACTIVE
	){

		scr_world_event_complete(
			"MIGRATION"
		);
	}

	return true;
}
