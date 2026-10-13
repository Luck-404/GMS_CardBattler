//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ENTITY_RECORD_GET_UNRESOLVED
// FUNCTION: Returns all unresolved logical entity records owned by an event.
//
// ARGUMENTS: _stct_world_event - Event state struct.
// RETURNS: Array of unresolved entity record structs.
//
//===============================================================================//

function scr_world_event_entity_record_get_unresolved(_stct_world_event){

	var _arr_unresolved = [];

	if (
		!is_struct(
			_stct_world_event
		) ||
		!variable_struct_exists(
			_stct_world_event,
			"_arr_entity_records"
		) ||
		!is_array(
			_stct_world_event
				._arr_entity_records
		)
	){
		return _arr_unresolved;
	}

	for (
		var _it_record = 0;
		_it_record <
			array_length(
				_stct_world_event
					._arr_entity_records
			);
		_it_record++
	){

		var _stct_record =
			_stct_world_event
				._arr_entity_records[
					_it_record
				];

		if (
			!is_struct(
				_stct_record
			)
		){
			continue;
		}

		if (
			!variable_struct_exists(
				_stct_record,
				"_flag_resolved"
			) ||
			!_stct_record
				._flag_resolved
		){
			array_push(
				_arr_unresolved,
				_stct_record
			);
		}
	}

	return _arr_unresolved;
}
