//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ALLOCATE_EVENT_UID
// FUNCTION: Allocates a stable logical World Event UID from the persistent
//           controller. GameMaker instance IDs are never used as event identity.
//
// RETURNS: Non-negative UID or -1 when no controller exists.
//
//===============================================================================//

function scr_world_event_allocate_event_uid(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return -1;
	}

	var _uid_world_event =
		_ref_controller
			._uid_next_world_event;

	_ref_controller
		._uid_next_world_event++;

	return _uid_world_event;
}
