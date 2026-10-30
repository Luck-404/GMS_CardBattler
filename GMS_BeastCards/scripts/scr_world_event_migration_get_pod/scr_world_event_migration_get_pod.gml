//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_GET_POD
// FUNCTION: Finds one persistent Migration pod by stable pod UID.
//
// ARGUMENTS: _stct_world_event - Active Migration event.
//            _uid_pod - Stable Migration pod UID.
// RETURNS: Matching pod struct or undefined.
//
//===============================================================================//

function scr_world_event_migration_get_pod(
	_stct_world_event,
	_uid_pod
){

	if (
		!is_struct(
			_stct_world_event
		) ||
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
		return undefined;
	}

	var _arr_pods =
		_stct_world_event
			._stct_payload
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
			is_struct(
				_stct_pod
			) &&
			_stct_pod._uid_pod ==
				_uid_pod
		){
			return _stct_pod;
		}
	}

	return undefined;
}
