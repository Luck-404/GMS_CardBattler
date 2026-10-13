//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ALLOCATE_ENTITY_UID
// FUNCTION: Allocates a stable logical event-entity UID from the persistent
//           controller. Room instance IDs are intentionally transient.
//
// RETURNS: Non-negative UID or -1 when no controller exists.
//
//===============================================================================//

function scr_world_event_allocate_entity_uid(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return -1;
	}

	var _uid_world_event_entity =
		_ref_controller
			._uid_next_world_event_entity;

	_ref_controller
		._uid_next_world_event_entity++;

	return _uid_world_event_entity;
}
