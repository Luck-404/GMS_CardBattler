//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ENTITY_RECORD_CREATE
// FUNCTION: Creates a persistent logical record for one future event-owned world
//           entity. No GameMaker instance ID is stored.
//
// ARGUMENTS: _uid_world_event - Owning World Event UID.
//            _uid_world_event_entity - Stable event-entity UID.
//            _str_entity_type - Logical entity type.
//            _str_spawn_id - Stable spawn-point ID.
//            _rm_room - Owning room.
//            _val_x / _val_y - Persisted exact position.
//            _stct_payload - Optional event-specific payload.
// RETURNS: New entity record struct.
//
//===============================================================================//

function scr_world_event_entity_record_create(
	_uid_world_event,
	_uid_world_event_entity,
	_str_entity_type,
	_str_spawn_id,
	_rm_room,
	_val_x,
	_val_y,
	_stct_payload=undefined
){

	if (!is_struct(_stct_payload)){
		_stct_payload = {};
	}

	return {
		_uid_world_event : _uid_world_event,
		_uid_world_event_entity : _uid_world_event_entity,

		_str_entity_type :
			string_upper(
				string(
					_str_entity_type
				)
			),

		_str_spawn_id :
			string_upper(
				string(
					_str_spawn_id
				)
			),

		_rm_room : _rm_room,

		_val_x : _val_x,
		_val_y : _val_y,

		_str_entity_state : "UNRESOLVED",

		_flag_resolved : false,
		_flag_claimed : false,
		_flag_removed : false,

		_stct_payload : _stct_payload
	};
}
