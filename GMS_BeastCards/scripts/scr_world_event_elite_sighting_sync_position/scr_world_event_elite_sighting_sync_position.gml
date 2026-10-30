//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_SYNC_POSITION
// FUNCTION: Persists the visible Elite Sighting Beast's current room position.
//
// RETURNS: True when the persistent entity record was updated.
//
//===============================================================================//

function scr_world_event_elite_sighting_sync_position(_ref_beast){

	if (
		!instance_exists(_ref_beast) ||
		!variable_instance_exists(
			_ref_beast,
			"_flag_world_event_instance"
		) ||
		!_ref_beast._flag_world_event_instance ||
		_ref_beast._str_world_event_id !=
			"ELITE_SIGHTING"
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

	if (!is_struct(_stct_record)){
		return false;
	}

	_stct_record._val_x = _ref_beast.x;
	_stct_record._val_y = _ref_beast.y;

	return true;
}
