//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ENTITY_RECORD_ADD
// FUNCTION: Adds one logical entity record to a World Event while preventing
//           duplicate event-entity UIDs.
//
// ARGUMENTS: _stct_world_event - Event state struct.
//            _stct_entity_record - Record created by the entity-record helper.
// RETURNS: True when the record was added.
//
//===============================================================================//

function scr_world_event_entity_record_add(
	_stct_world_event,
	_stct_entity_record
){

	if (
		!is_struct(
			_stct_world_event
		) ||
		!is_struct(
			_stct_entity_record
		)
	){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_world_event,
			"_arr_entity_records"
		) ||
		!is_array(
			_stct_world_event
				._arr_entity_records
		)
	){
		_stct_world_event
			._arr_entity_records = [];
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

		var _stct_existing =
			_stct_world_event
				._arr_entity_records[
					_it_record
				];

		if (
			is_struct(
				_stct_existing
			) &&
			_stct_existing
				._uid_world_event_entity ==
			_stct_entity_record
				._uid_world_event_entity
		){
			return false;
		}
	}

	array_push(
		_stct_world_event
			._arr_entity_records,
		_stct_entity_record
	);

	return true;
}
