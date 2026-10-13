//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ENTITY_RECORD_GET
// FUNCTION: Finds one persistent entity record by stable logical UID.
//
// ARGUMENTS: _stct_world_event - Event state struct.
//            _uid_world_event_entity - Entity UID to find.
// RETURNS: Matching struct or undefined.
//
//===============================================================================//

function scr_world_event_entity_record_get(
	_stct_world_event,
	_uid_world_event_entity
){

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
		return undefined;
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
			is_struct(
				_stct_record
			) &&
			_stct_record
				._uid_world_event_entity ==
			_uid_world_event_entity
		){
			return _stct_record;
		}
	}

	return undefined;
}
