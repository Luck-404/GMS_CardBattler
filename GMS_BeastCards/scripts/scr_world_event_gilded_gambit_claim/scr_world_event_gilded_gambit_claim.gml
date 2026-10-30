//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_GILDED_GAMBIT_CLAIM
// FUNCTION: Locks the five-chest choice, grants the standard premium World Event
//           package once, removes the four unchosen chests, and completes the event.
//
// ARGUMENTS: _uid_world_event_entity - Chosen chest entity UID.
// RETURNS: True when the chest successfully claims the event.
//
//===============================================================================//

function scr_world_event_gilded_gambit_claim(_uid_world_event_entity){

	var _ref_controller = scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_event = _ref_controller._stct_active_world_event;

	if (
		!is_struct(_stct_event) ||
		_stct_event._state_world_event != ENUM_WORLD_EVENT_STATE.ACTIVE ||
		_stct_event._str_event_id != "CHOOSE_A_CHEST" ||
		!is_struct(_stct_event._stct_payload)
	){
		return false;
	}

	var _stct_payload = _stct_event._stct_payload;

	if (
		variable_struct_exists(_stct_payload,"_flag_gilded_gambit_choice_made") &&
		_stct_payload._flag_gilded_gambit_choice_made
	){
		return false;
	}

	var _stct_choice =
		scr_world_event_entity_record_get(
			_stct_event,
			_uid_world_event_entity
		);

	if (
		!is_struct(_stct_choice) ||
		_stct_choice._str_entity_type != "GILDED_GAMBIT_CHEST" ||
		_stct_choice._flag_resolved
	){
		return false;
	}

	var _stct_reward =
		scr_world_event_reward_resolve(
			_stct_event
		);

	if (
		!is_struct(_stct_reward) ||
		!variable_struct_exists(_stct_reward,"_flag_success") ||
		!_stct_reward._flag_success
	){
		return false;
	}

	_stct_payload._flag_gilded_gambit_choice_made = true;
	_stct_payload._uid_gilded_gambit_choice = _uid_world_event_entity;
	_stct_event._ct_progress = 1;

	for (
		var _it_record = 0;
		_it_record < array_length(_stct_event._arr_entity_records);
		_it_record++
	){

		var _stct_record = _stct_event._arr_entity_records[_it_record];

		if (
			!is_struct(_stct_record) ||
			_stct_record._str_entity_type != "GILDED_GAMBIT_CHEST"
		){
			continue;
		}

		_stct_record._flag_resolved = true;
		_stct_record._flag_claimed =
			_stct_record._uid_world_event_entity == _uid_world_event_entity;
		_stct_record._flag_removed =
			_stct_record._uid_world_event_entity != _uid_world_event_entity;
		_stct_record._str_entity_state =
			_stct_record._flag_claimed
			? "CLAIMED"
			: "UNCHOSEN";

		if (is_struct(_stct_record._stct_payload)){
			_stct_record._stct_payload._flag_selected =
				_stct_record._flag_claimed;
		}
	}

	var _ct_chests = instance_number(obj_overworld_treasure_chest);

	for (var _it_chest = _ct_chests - 1;_it_chest >= 0;_it_chest--){

		var _ref_chest = instance_find(obj_overworld_treasure_chest,_it_chest);

		if (
			!instance_exists(_ref_chest) ||
			!variable_instance_exists(_ref_chest,"_flag_world_event_instance") ||
			!_ref_chest._flag_world_event_instance ||
			!variable_instance_exists(_ref_chest,"_uid_world_event") ||
			_ref_chest._uid_world_event != _stct_event._uid_world_event
		){
			continue;
		}

		if (_ref_chest._uid_world_event_entity == _uid_world_event_entity){
			_ref_chest._flag_triggered = true;
			_ref_chest.image_index = 1;
			continue;
		}

		instance_destroy(_ref_chest);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"GILDED_GAMBIT",
		_ref_controller,
		"GILDED GAMBIT CHEST CLAIMED" +
		" | EVENT UID: " + string(_stct_event._uid_world_event) +
		" | CHEST UID: " + string(_uid_world_event_entity),
		"REWARD",
		"SCR_WORLD_EVENT_GILDED_GAMBIT_CLAIM"
	);

	return scr_world_event_complete("GILDED GAMBIT CHEST");
}
