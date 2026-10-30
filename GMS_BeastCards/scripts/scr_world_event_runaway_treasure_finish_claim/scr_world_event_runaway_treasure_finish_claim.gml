//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_FINISH_CLAIM
// FUNCTION: Finishes the Runaway Treasure Beast catch after its short chest-drop
//           + poof presentation. Spawns eight persistent treasure sparkles, removes
//           the Beast, and completes the World Event.
//
// ARGUMENTS: _uid_world_event_entity - Runaway Beast entity UID.
//            _val_x / _val_y - Final catch position.
// RETURNS: True when the event successfully completes.
//
//===============================================================================//

function scr_world_event_runaway_treasure_finish_claim(
	_uid_world_event_entity,
	_val_x,
	_val_y
){

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
		_stct_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.ACTIVE ||
		_stct_event._str_event_id !=
			"RUNAWAY_TREASURE_BEAST" ||
		!is_struct(_stct_event._stct_payload)
	){
		return false;
	}

	var _stct_payload =
		_stct_event._stct_payload;

	if (
		variable_struct_exists(
			_stct_payload,
			"_flag_runaway_treasure_caught"
		) &&
		_stct_payload._flag_runaway_treasure_caught
	){
		return false;
	}

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_event,
			_uid_world_event_entity
		);

	if (
		!is_struct(_stct_record) ||
		_stct_record._str_entity_type !=
			"RUNAWAY_TREASURE_BEAST" ||
		_stct_record._flag_resolved
	){
		return false;
	}

	if (
		!scr_world_event_runaway_treasure_spawn_drops(
			_stct_event,
			_stct_record,
			_val_x,
			_val_y
		)
	){
		return false;
	}

	_stct_record._val_x = _val_x;
	_stct_record._val_y = _val_y;
	_stct_record._flag_resolved = true;
	_stct_record._flag_claimed = true;
	_stct_record._flag_removed = true;
	_stct_record._str_entity_state = "CAUGHT";

	_stct_payload._flag_runaway_treasure_caught = true;
	_stct_payload._val_runaway_treasure_catch_x = _val_x;
	_stct_payload._val_runaway_treasure_catch_y = _val_y;

	_stct_event._ct_progress = 1;


	//================//
	//REMOVE BEAST//
	//================//
	var _ct_beasts =
		instance_number(obj_overworld_beast);

	for (
		var _it_beast = _ct_beasts - 1;
		_it_beast >= 0;
		_it_beast--
	){
		var _ref_beast =
			instance_find(
				obj_overworld_beast,
				_it_beast
			);

		if (
			!instance_exists(_ref_beast) ||
			!variable_instance_exists(
				_ref_beast,
				"_flag_world_event_instance"
			) ||
			!_ref_beast._flag_world_event_instance ||
			!variable_instance_exists(
				_ref_beast,
				"_uid_world_event_entity"
			) ||
			_ref_beast._uid_world_event_entity !=
				_uid_world_event_entity
		){
			continue;
		}

		instance_destroy(_ref_beast);
	}

	audio_play_sound(
		snd_overworld_treasure_claim,
		2,
		false
	);

	scr_debug_log(
		"WORLD_EVENT",
		"RUNAWAY_TREASURE",
		_ref_controller,
		"RUNAWAY TREASURE BEAST CAUGHT" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | ENTITY UID: " +
		string(_uid_world_event_entity) +
		" | SPARKLES: " +
		string(
			_stct_payload
				._ct_runaway_treasure_sparkles_total
		),
		"REWARD",
		"SCR_WORLD_EVENT_RUNAWAY_TREASURE_FINISH_CLAIM"
	);

	return scr_world_event_complete(
		"RUNAWAY TREASURE BEAST CAUGHT"
	);
}
