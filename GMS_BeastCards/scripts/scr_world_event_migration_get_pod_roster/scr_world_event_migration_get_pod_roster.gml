//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_GET_POD_ROSTER
// FUNCTION: Returns the exact initialized Beast structs that remain unresolved in
//           one Migration pod.
//
// ARGUMENTS: _stct_world_event - Active Migration event.
//            _stct_pod - Persistent Migration pod.
// RETURNS: Array of unresolved initialized Beast structs.
//
//===============================================================================//

function scr_world_event_migration_get_pod_roster(
	_stct_world_event,
	_stct_pod
){

	var _arr_roster = [];

	if (
		!is_struct(
			_stct_world_event
		) ||
		!is_struct(
			_stct_pod
		) ||
		!is_array(
			_stct_pod
				._arr_member_units
		) ||
		!is_array(
			_stct_pod
				._arr_member_entity_uids
		)
	){
		return _arr_roster;
	}

	var _ct_members =
		min(
			array_length(
				_stct_pod
					._arr_member_units
			),
			array_length(
				_stct_pod
					._arr_member_entity_uids
			)
		);

	for (
		var _it_member = 0;
		_it_member < _ct_members;
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
			!is_struct(
				_stct_record
			) ||
			_stct_record._flag_resolved
		){
			continue;
		}

		var _stct_unit =
			_stct_pod
				._arr_member_units[
					_it_member
				];

		if (!is_struct(_stct_unit)){
			continue;
		}

		array_push(
			_arr_roster,
			_stct_unit
		);
	}

	return _arr_roster;
}
