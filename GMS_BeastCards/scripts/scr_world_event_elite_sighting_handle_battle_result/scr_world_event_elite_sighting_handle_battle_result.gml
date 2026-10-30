//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ELITE_SIGHTING_HANDLE_BATTLE_RESULT
// FUNCTION: Applies one resolved Elite Sighting exact-battle result.
//
//           WIN:
//           - permanently resolves the Tier 2 Elite encounter;
//           - completes the World Event and grants Phase V premium rewards.
//
//           LOSS:
//           - event remains ACTIVE;
//           - any successfully captured normal allies remain removed;
//           - remaining roster members are restored to full HP for reconstruction.
//
// ARGUMENTS: _stct_context - Resolved Phase III battle context.
// RETURNS: True when the active Elite Sighting event was processed.
//
//===============================================================================//

function scr_world_event_elite_sighting_handle_battle_result(_stct_context){

	if (!is_struct(_stct_context)){
		return false;
	}

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
		_stct_event._uid_world_event !=
			_stct_context._uid_world_event ||
		_stct_event._str_event_id !=
			"ELITE_SIGHTING" ||
		!is_struct(_stct_event._stct_payload)
	){
		return false;
	}

	var _str_result =
		string_upper(
			string(
				_stct_context._str_result
			)
		);

	if (
		_str_result != "WIN" &&
		_str_result != "LOSS"
	){
		return false;
	}

	var _stct_payload =
		_stct_event._stct_payload;

	var _stct_record =
		scr_world_event_entity_record_get(
			_stct_event,
			_stct_context._uid_world_event_entity
		);

	if (
		!is_struct(_stct_record) ||
		!is_struct(_stct_record._stct_payload) ||
		!variable_struct_exists(
			_stct_record._stct_payload,
			"_arr_enemy_units"
		) ||
		!is_array(
			_stct_record._stct_payload._arr_enemy_units
		)
	){
		return false;
	}

	if (_str_result == "WIN"){

		_stct_record._flag_resolved = true;
		_stct_record._flag_removed = true;
		_stct_record._str_entity_state = "DEFEATED";

		_stct_payload._flag_elite_sighting_defeated = true;
		_stct_event._ct_progress = 1;
		_stct_event._flag_room_initialized = false;

		scr_debug_log(
			"WORLD_EVENT",
			"ELITE_SIGHTING",
			_ref_controller,
			"ELITE SIGHTING DEFEATED" +
			" | EVENT UID: " +
			string(_stct_event._uid_world_event) +
			" | RESULT: WIN" +
			" | RISK TIER: " +
			string(
				_stct_payload._val_elite_sighting_risk_tier
			),
			"INFO",
			"SCR_WORLD_EVENT_ELITE_SIGHTING_HANDLE_BATTLE_RESULT"
		);

		return scr_world_event_complete(
			"ELITE SIGHTING WIN"
		);
	}

	var _arr_old_roster =
		_stct_record
			._stct_payload
			._arr_enemy_units;

	var _arr_remaining_roster = [];

	for (
		var _it_unit = 0;
		_it_unit < array_length(_arr_old_roster);
		_it_unit++
	){

		var _stct_unit =
			_arr_old_roster[_it_unit];

		if (!is_struct(_stct_unit)){
			continue;
		}

		var _flag_captured =
			array_contains(
				_stct_context._arr_captured_enemy_uids,
				_stct_unit._uid_beast
			);

		if (_flag_captured){
			continue;
		}

		if (
			!scr_world_event_elite_sighting_reset_unit(
				_stct_unit,
				_stct_payload._uid_elite_sighting_beast
			)
		){
			return false;
		}

		array_push(
			_arr_remaining_roster,
			_stct_unit
		);
	}

	if (
		array_length(_arr_remaining_roster) <= 0 ||
		!scr_battle_validate_exact_enemy_roster(
			_arr_remaining_roster
		)
	){
		return false;
	}

	_stct_record._stct_payload._arr_enemy_units =
		_arr_remaining_roster;

	_stct_payload._arr_elite_sighting_roster =
		_arr_remaining_roster;

	_stct_event._flag_room_initialized = false;

	scr_debug_log(
		"WORLD_EVENT",
		"ELITE_SIGHTING",
		_ref_controller,
		"ELITE SIGHTING BATTLE LOST — ENCOUNTER PERSISTS" +
		" | EVENT UID: " +
		string(_stct_event._uid_world_event) +
		" | CAPTURED ALLIES REMOVED: " +
		string(
			array_length(
				_stct_context._arr_captured_enemy_uids
			)
		) +
		" | ROSTER REMAINING: " +
		string(
			array_length(
				_arr_remaining_roster
			)
		),
		"INFO",
		"SCR_WORLD_EVENT_ELITE_SIGHTING_HANDLE_BATTLE_RESULT"
	);

	return true;
}
