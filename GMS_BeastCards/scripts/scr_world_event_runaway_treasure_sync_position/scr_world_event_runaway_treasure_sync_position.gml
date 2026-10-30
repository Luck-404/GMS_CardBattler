//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_SYNC_POSITION
// FUNCTION: Persists the live Runaway Treasure Beast position so room re-entry
//           resumes from its latest leashed location.
//
//===============================================================================//

function scr_world_event_runaway_treasure_sync_position(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		!_ref_beast._flag_world_event_instance ||
		_ref_beast._str_world_event_id !=
			"RUNAWAY_TREASURE_BEAST" ||
		!_ref_beast._flag_runaway_treasure_beast ||
		_ref_beast._uid_world_event_entity < 0
	){
		return false;
	}

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event =
		_ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._uid_world_event !=
			_ref_beast._uid_world_event
	){
		return false;
	}

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_event,
			_ref_beast._uid_world_event_entity
		);

	if (
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved
	){
		return false;
	}

	_stct_record._val_x = _ref_beast.x;
	_stct_record._val_y = _ref_beast.y;

	return true;
}
