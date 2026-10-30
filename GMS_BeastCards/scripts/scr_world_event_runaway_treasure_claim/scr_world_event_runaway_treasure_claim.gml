//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_CLAIM
// FUNCTION: Begins the Runaway Treasure Beast catch presentation on overworld
//           collision. No battle starts.
//
//           The live Beast stops moving while its attached chest drops toward the
//           ground. SCR_WORLD_EVENT_RUNAWAY_TREASURE_FINISH_CLAIM resolves the
//           poof, eight-direction sparkle burst, persistence, and completion.
//
// ARGUMENTS: _uid_world_event_entity - Runaway Beast entity UID.
//            _val_x / _val_y - Catch position.
// RETURNS: True when the catch animation successfully begins.
//
//===============================================================================//

function scr_world_event_runaway_treasure_claim(
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

	var _ref_runaway = noone;
	var _ct_beasts =
		instance_number(obj_overworld_beast);

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

		_ref_runaway = _ref_beast;
		break;
	}

	if (!instance_exists(_ref_runaway)){
		return false;
	}

	if (_ref_runaway._flag_runaway_treasure_catch_animation){
		return true;
	}

	_stct_record._val_x = _val_x;
	_stct_record._val_y = _val_y;
	_stct_record._str_entity_state = "CATCHING";

	_ref_runaway._flag_runaway_treasure_catch_animation = true;
	_ref_runaway._ct_runaway_treasure_catch_animation =
		_ref_runaway._ct_runaway_treasure_catch_animation_total;

	_ref_runaway._val_target_x = _ref_runaway.x;
	_ref_runaway._val_target_y = _ref_runaway.y;

	audio_play_sound(
		snd_overworld_treasure_chest_open,
		2,
		false
	);

	scr_debug_log(
		"WORLD_EVENT",
		"RUNAWAY_TREASURE",
		_ref_controller,
		"RUNAWAY TREASURE BEAST CATCH ANIMATION STARTED" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | ENTITY UID: " +
		string(_uid_world_event_entity),
		"INFO",
		"SCR_WORLD_EVENT_RUNAWAY_TREASURE_CLAIM"
	);

	return true;
}
