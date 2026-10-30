//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_RUNAWAY_TREASURE_CLAIM_SPARKLE
// FUNCTION: Resolves one persistent one-shot sparkle before its normal treasure
//           reward is granted by OBJ_OVERWORLD_TREASURE_SPARKLE.
//
// ARGUMENTS: _uid_world_event_entity - Sparkle entity UID.
// RETURNS: True when this sparkle is newly claimed.
//
//===============================================================================//

function scr_world_event_runaway_treasure_claim_sparkle(
	_uid_world_event_entity
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
		_stct_event._str_event_id !=
			"RUNAWAY_TREASURE_BEAST" ||
		_stct_event._state_world_event !=
			ENUM_WORLD_EVENT_STATE.COMPLETED ||
		!is_struct(_stct_event._stct_payload)
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
			"RUNAWAY_TREASURE_SPARKLE" ||
		_stct_record._flag_resolved
	){
		return false;
	}

	_stct_record._flag_resolved = true;
	_stct_record._flag_claimed = true;
	_stct_record._flag_removed = true;
	_stct_record._str_entity_state = "CLAIMED";

	var _ct_remaining = 0;

	for (
		var _it_record = 0;
		_it_record < array_length(_stct_event._arr_entity_records);
		_it_record++
	){

		var _stct_check =
			_stct_event
				._arr_entity_records[
					_it_record
				];

		if (
			is_struct(_stct_check) &&
			_stct_check._str_entity_type ==
				"RUNAWAY_TREASURE_SPARKLE" &&
			!_stct_check._flag_resolved
		){
			_ct_remaining++;
		}
	}

	_stct_event
		._stct_payload
		._ct_runaway_treasure_sparkles_remaining =
		_ct_remaining;

	// Once every drop is collected, only a short cleared-state display is needed.
	if (_ct_remaining <= 0){

		_stct_event._val_cleanup_time_remaining =
			min(
				_stct_event._val_cleanup_time_remaining,
				8
			);
	}

	scr_debug_log(
		"WORLD_EVENT",
		"RUNAWAY_TREASURE",
		_ref_controller,
		"RUNAWAY TREASURE SPARKLE CLAIMED" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | SPARKLE UID: " +
		string(_uid_world_event_entity) +
		" | REMAINING: " +
		string(_ct_remaining),
		"REWARD",
		"SCR_WORLD_EVENT_RUNAWAY_TREASURE_CLAIM_SPARKLE"
	);

	return true;
}
