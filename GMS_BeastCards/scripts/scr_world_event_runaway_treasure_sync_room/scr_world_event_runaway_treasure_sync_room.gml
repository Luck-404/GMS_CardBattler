//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_SYNC_ROOM
// FUNCTION: Reconstructs the active Runaway Treasure Beast or unresolved completion sparkles from persistent records after clearing stale same-event live state on a fresh room reconstruction.
//
//===============================================================================//

function scr_world_event_runaway_treasure_sync_room(){

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
			"RUNAWAY_TREASURE_BEAST" ||
		room != _stct_event._rm_target ||
		(
			_stct_event._state_world_event !=
				ENUM_WORLD_EVENT_STATE.ACTIVE &&
			_stct_event._state_world_event !=
				ENUM_WORLD_EVENT_STATE.COMPLETED
		)
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	var _stct_payload =
		_stct_event._stct_payload;

	//================//
	//ACTIVE BEAST//
	//================//
	if (
		_stct_event._state_world_event ==
			ENUM_WORLD_EVENT_STATE.ACTIVE
	){

		if (
			!variable_struct_exists(
				_stct_payload,
				"_flag_runaway_treasure_generated"
			) ||
			!_stct_payload._flag_runaway_treasure_generated
		){

			if (!scr_world_event_runaway_treasure_generate()){
				return false;
			}
		}

		if (
			variable_struct_exists(
				_stct_payload,
				"_flag_runaway_treasure_caught"
			) &&
			_stct_payload._flag_runaway_treasure_caught
		){
			return true;
		}

		//========================//
		//RECONSTRUCTION RESET//
		//========================//
		if (!_stct_event._flag_room_initialized){
			scr_world_event_cleanup_room_instances(_stct_event._uid_world_event);
		}

		var _uid_beast =
			_stct_payload
				._uid_runaway_treasure_beast;

		var _stct_beast_record =
			scr_world_event_entity_record_get(
				_stct_event,
				_uid_beast
			);

		if (
			!is_struct(_stct_beast_record) ||
			_stct_beast_record._flag_resolved
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
					_uid_beast
			){
				_flag_live = true;
				break;
			}
		}

		if (!_flag_live){

			if (
				!instance_exists(
					scr_world_event_runaway_treasure_spawn_beast(
						_stct_event,
						_stct_beast_record
					)
				)
			){
				return false;
			}
		}

		_stct_event._flag_room_initialized = true;
		return true;
	}

	//================//
	//COMPLETED DROPS//
	//================//
	if (
		!variable_struct_exists(
			_stct_payload,
			"_flag_runaway_treasure_drops_generated"
		) ||
		!_stct_payload._flag_runaway_treasure_drops_generated
	){
		return true;
	}

	//========================//
	//RECONSTRUCTION RESET//
	//========================//
	if (!_stct_event._flag_room_initialized){
		scr_world_event_cleanup_room_instances(_stct_event._uid_world_event);
	}

	for (
		var _it_record = 0;
		_it_record < array_length(_stct_event._arr_entity_records);
		_it_record++
	){

		var _stct_record =
			_stct_event
				._arr_entity_records[
					_it_record
				];

		if (
			!is_struct(_stct_record) ||
			_stct_record._str_entity_type !=
				"RUNAWAY_TREASURE_SPARKLE" ||
			_stct_record._flag_resolved
		){
			continue;
		}

		var _flag_live = false;
		var _ct_sparkles =
			instance_number(
				obj_overworld_treasure_sparkle
			);

		for (
			var _it_live = 0;
			_it_live < _ct_sparkles;
			_it_live++
		){

			var _ref_live =
				instance_find(
					obj_overworld_treasure_sparkle,
					_it_live
				);

			if (
				instance_exists(_ref_live) &&
				variable_instance_exists(
					_ref_live,
					"_flag_world_event_instance"
				) &&
				_ref_live._flag_world_event_instance &&
				variable_instance_exists(
					_ref_live,
					"_uid_world_event_entity"
				) &&
				_ref_live._uid_world_event_entity ==
					_stct_record._uid_world_event_entity
			){
				_flag_live = true;
				break;
			}
		}

		if (!_flag_live){

			scr_world_event_runaway_treasure_spawn_sparkle(
				_stct_event,
				_stct_record
			);
		}
	}

	_stct_event._flag_room_initialized = true;

	return true;
}
