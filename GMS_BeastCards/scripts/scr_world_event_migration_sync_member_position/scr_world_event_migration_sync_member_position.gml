//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_SYNC_MEMBER_POSITION
// FUNCTION: Persists a live Migration member's current overworld position so room
//           reconstruction resumes from its latest leashed location.
//
// ARGUMENTS: _ref_beast - Live Migration OBJ_OVERWORLD_BEAST.
// RETURNS: True when its persistent entity record was updated.
//
//===============================================================================//

function scr_world_event_migration_sync_member_position(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		!_ref_beast._flag_world_event_instance ||
		_ref_beast._str_world_event_id !=
			"MIGRATION" ||
		_ref_beast._uid_world_event_entity <
			0
	){
		return false;
	}

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_world_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(
			_stct_world_event
		) ||
		_stct_world_event._uid_world_event !=
			_ref_beast._uid_world_event
	){
		return false;
	}

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_world_event,
			_ref_beast
				._uid_world_event_entity
		);

	if (
		!is_struct(
			_stct_record
		) ||
		_stct_record._flag_resolved
	){
		return false;
	}

	_stct_record._val_x =
		_ref_beast.x;

	_stct_record._val_y =
		_ref_beast.y;

	return true;
}
