//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_SYNC_ROOM
// FUNCTION: Generates or reconstructs the unresolved Elite Sighting encounter from persistent records after clearing stale same-event live room state on a fresh reconstruction.
//
//===============================================================================//

function scr_world_event_elite_sighting_sync_room(){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._str_event_id !=
			"ELITE_SIGHTING" ||
		_stct_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE ||
		room != _stct_event._rm_target
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	var _stct_payload =
		_stct_event._stct_payload;

	if (
		!variable_struct_exists(
			_stct_payload,
			"_flag_elite_sighting_generated"
		) ||
		!_stct_payload._flag_elite_sighting_generated
	){

		if (!scr_world_event_elite_sighting_generate()){
			return false;
		}
	}

	if (
		variable_struct_exists(
			_stct_payload,
			"_flag_elite_sighting_defeated"
		) &&
		_stct_payload._flag_elite_sighting_defeated
	){
		return true;
	}

	//========================//
	//RECONSTRUCTION RESET//
	//========================//
	if (!_stct_event._flag_room_initialized){
		scr_world_event_cleanup_room_instances(_stct_event._uid_world_event);
	}

	var _uid_entity =
		_stct_payload
			._uid_elite_sighting_entity;

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_event,
			_uid_entity
		);

	if (
		!is_struct(_stct_record) ||
		_stct_record._flag_resolved
	){
		return false;
	}

	var _flag_live = false;
	var _ct_beasts =
		instance_number(
			obj_overworld_beast
		);

	for (
		var _it_beast = 0;
		_it_beast < _ct_beasts;
		_it_beast++
	){

		var _ref_beast =
			instance_find(
				obj_overworld_beast,
				_it_beast
			);

		if (
			instance_exists(_ref_beast) &&
			variable_instance_exists(
				_ref_beast,
				"_flag_world_event_instance"
			) &&
			_ref_beast._flag_world_event_instance &&
			variable_instance_exists(
				_ref_beast,
				"_uid_world_event_entity"
			) &&
			_ref_beast._uid_world_event_entity ==
				_uid_entity
		){
			_flag_live = true;
			break;
		}
	}

	if (!_flag_live){

		if (
			!instance_exists(
				scr_world_event_elite_sighting_spawn_beast(
					_stct_event,
					_stct_record
				)
			)
		){
			return false;
		}
	}

	_stct_event._flag_room_initialized = true;

	return true;
}
