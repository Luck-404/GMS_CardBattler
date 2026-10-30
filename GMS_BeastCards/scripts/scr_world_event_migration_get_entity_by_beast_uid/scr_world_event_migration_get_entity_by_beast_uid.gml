//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_GET_ENTITY_BY_BEAST_UID
// FUNCTION: Finds a Migration member entity record from its original enemy Beast
//           UID.
//
// ARGUMENTS: _stct_world_event - Active Migration event.
//            _uid_beast - Original persistent Migration Beast UID.
// RETURNS: Matching entity record or undefined.
//
//===============================================================================//

function scr_world_event_migration_get_entity_by_beast_uid(
	_stct_world_event,
	_uid_beast
){

	if (
		!is_struct(
			_stct_world_event
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
			!is_struct(
				_stct_record
			) ||
			!is_struct(
				_stct_record
					._stct_payload
			) ||
			!variable_struct_exists(
				_stct_record
					._stct_payload,
				"_uid_beast"
			)
		){
			continue;
		}

		if (
			_stct_record
				._stct_payload
				._uid_beast ==
			_uid_beast
		){
			return _stct_record;
		}
	}

	return undefined;
}
