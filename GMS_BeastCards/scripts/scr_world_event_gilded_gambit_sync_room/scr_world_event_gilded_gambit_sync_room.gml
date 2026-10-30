//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GILDED_GAMBIT_SYNC_ROOM
// FUNCTION: Generates or reconstructs unresolved Gilded Gambit chests from persistent records after clearing stale same-event live room state on a fresh reconstruction.
//
//===============================================================================//

function scr_world_event_gilded_gambit_sync_room(){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event = _ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE ||
		_stct_event._str_event_id != "CHOOSE_A_CHEST" ||
		room != _stct_event._rm_target
	){
		return false;
	}

	if (!is_struct(_stct_event._stct_payload)){
		_stct_event._stct_payload = {};
	}

	var _stct_payload = _stct_event._stct_payload;

	if (
		!variable_struct_exists(_stct_payload,"_flag_gilded_gambit_generated") ||
		!_stct_payload._flag_gilded_gambit_generated
	){
		if (!scr_world_event_gilded_gambit_generate()){
			return false;
		}
	}

	if (
		variable_struct_exists(_stct_payload,"_flag_gilded_gambit_choice_made") &&
		_stct_payload._flag_gilded_gambit_choice_made
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

		var _stct_record = _stct_event._arr_entity_records[_it_record];

		if (
			!is_struct(_stct_record) ||
			_stct_record._str_entity_type != "GILDED_GAMBIT_CHEST" ||
			_stct_record._flag_resolved
		){
			continue;
		}

		var _flag_live = false;
		var _ct_live = instance_number(obj_overworld_treasure_chest);

		for (var _it_live = 0;_it_live < _ct_live;_it_live++){

			var _ref_live = instance_find(obj_overworld_treasure_chest,_it_live);

			if (
				instance_exists(_ref_live) &&
				variable_instance_exists(_ref_live,"_flag_world_event_instance") &&
				_ref_live._flag_world_event_instance &&
				variable_instance_exists(_ref_live,"_uid_world_event_entity") &&
				_ref_live._uid_world_event_entity == _stct_record._uid_world_event_entity
			){
				_flag_live = true;
				break;
			}
		}

		if (!_flag_live){
			scr_world_event_gilded_gambit_spawn_chest(_stct_event,_stct_record);
		}
	}

	_stct_event._flag_room_initialized = true;
	return true;
}
