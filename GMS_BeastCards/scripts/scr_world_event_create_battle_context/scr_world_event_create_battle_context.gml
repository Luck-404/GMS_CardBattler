//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_CREATE_BATTLE_CONTEXT
// FUNCTION: Creates a reusable battle context for a World Event or scripted
//           exact-roster encounter.
//
// ARGUMENTS: _uid_world_event - Owning World Event UID, or -1 for non-event.
//            _str_event_id - Owning World Event ID.
//            _uid_world_event_entity - Trigger/entity UID.
//            _uid_world_event_pod - Pod/group UID when applicable.
//            _str_encounter_type - MIGRATION_POD, ELITE_SIGHTING, SCRIPTED, etc.
//            _flag_suppress_world_event_roll - Suppress next post-battle roll.
// RETURNS: New active battle-context struct.
//
//===============================================================================//

function scr_world_event_create_battle_context(
	_uid_world_event=-1,
	_str_event_id="",
	_uid_world_event_entity=-1,
	_uid_world_event_pod=-1,
	_str_encounter_type="SCRIPTED",
	_flag_suppress_world_event_roll=true
){

	var _stct_context =
		scr_world_event_create_empty_battle_context();

	_stct_context._flag_active =
		true;

	_stct_context._uid_world_event =
		_uid_world_event;

	_stct_context._str_event_id =
		string_upper(
			string(
				_str_event_id
			)
		);

	_stct_context._uid_world_event_entity =
		_uid_world_event_entity;

	_stct_context._uid_world_event_pod =
		_uid_world_event_pod;

	_stct_context._str_encounter_type =
		string_upper(
			string(
				_str_encounter_type
			)
		);

	_stct_context._flag_suppress_world_event_roll =
		_flag_suppress_world_event_roll;

	return _stct_context;
}
