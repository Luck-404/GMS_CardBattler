//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REGISTER_BATTLE_COMPLETION
// FUNCTION: Registers one completed normal battle and performs the production
//           1-in-50 World Event roll when no World Event currently occupies the
//           global event slot.
//
//           Future World Event battles suppress this roll by setting
//           _flag_suppress_next_battle_roll before their result is registered.
//
// ARGUMENTS: _str_result - WIN or LOSS.
// RETURNS: True only when a new World Event is generated.
//
//===============================================================================//

function scr_world_event_register_battle_completion(_str_result){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	_str_result =
		string_upper(
			string(
				_str_result
			)
		);

	if (
		_str_result != "WIN" &&
		_str_result != "LOSS"
	){
		return false;
	}

	_ref_controller
		._ct_battle_completions_seen++;

	_ref_controller
		._str_last_battle_result =
		_str_result;

	//========================//
//CONSUME SUPPRESSION FIRST//
//========================//
	// This occurs before the active-event check so a future event-generated battle
	// cannot leave suppression armed and accidentally consume the next normal fight.
	if (
		_ref_controller
			._flag_suppress_next_battle_roll
	){

		_ref_controller
			._flag_suppress_next_battle_roll =
			false;

		_ref_controller
			._flag_last_world_event_roll_success =
			false;

		_ref_controller
			._ct_last_world_event_roll =
			0;

		scr_debug_log(
			"WORLD_EVENT",
			"ROLL",
			_ref_controller,
			"WORLD EVENT ROLL SUPPRESSED" +
			" | BATTLE RESULT: " +
			_str_result +
			" | REASON: EVENT/SCRIPTED BATTLE CONTEXT",
			"INFO",
			"SCR_WORLD_EVENT_REGISTER_BATTLE_COMPLETION"
		);

		return false;
	}

	//================//
//ACTIVE EVENT BLOCK//
//================//
	if (
		is_struct(
			_ref_controller
				._stct_active_world_event
		) &&
		_ref_controller
			._stct_active_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.NONE
	){

		_ref_controller
			._flag_last_world_event_roll_success =
			false;

		_ref_controller
			._ct_last_world_event_roll =
			0;

		scr_debug_log(
			"WORLD_EVENT",
			"ROLL",
			_ref_controller,
			"WORLD EVENT ROLL SKIPPED" +
			" | BATTLE RESULT: " +
			_str_result +
			" | REASON: ACTIVE WORLD EVENT" +
			" | EVENT: " +
			_ref_controller
				._stct_active_world_event
				._str_event_id,
			"INFO",
			"SCR_WORLD_EVENT_REGISTER_BATTLE_COMPLETION"
		);

		return false;
	}

	//================//
//ROLL//
//================//
	var _ct_denominator =
		max(
			1,
			floor(
				_ref_controller
					._ct_world_event_roll_denominator
			)
		);

	var _ct_roll =
		irandom_range(
			1,
			_ct_denominator
		);

	_ref_controller
		._ct_last_world_event_roll =
		_ct_roll;

	var _flag_success =
		_ct_roll ==
		1;

	_ref_controller
		._flag_last_world_event_roll_success =
		_flag_success;

	scr_debug_log(
		"WORLD_EVENT",
		"ROLL",
		_ref_controller,
		"WORLD EVENT ROLL" +
		" | BATTLE RESULT: " +
		_str_result +
		" | ROLL: " +
		string(
			_ct_roll
		) +
		"/" +
		string(
			_ct_denominator
		) +
		" | RESULT: " +
		(
			_flag_success
			? "SUCCESS"
			: "NO EVENT"
		),
		"INFO",
		"SCR_WORLD_EVENT_REGISTER_BATTLE_COMPLETION"
	);

	if (!_flag_success){
		return false;
	}

	//================//
//SELECT EVENT//
//================//
	var _rm_target =
		scr_world_event_select_random_room();

	var _str_event_id =
		scr_world_event_select_random_event();

	if (
		_rm_target == undefined ||
		_str_event_id == ""
	){

		scr_debug_log(
			"WORLD_EVENT",
			"ROLL",
			_ref_controller,
			"WORLD EVENT GENERATION FAILED AFTER SUCCESSFUL ROLL" +
			" | ROOM: " +
			string(
				_rm_target
			) +
			" | EVENT: " +
			_str_event_id,
			"ERROR",
			"SCR_WORLD_EVENT_REGISTER_BATTLE_COMPLETION"
		);

		return false;
	}

	var _stct_world_event =
		scr_world_event_create(
			_str_event_id,
			_rm_target,
			{
				_str_generation_source :
					"BATTLE_COMPLETION",

				_str_battle_result :
					_str_result,

				_ct_roll :
					_ct_roll,

				_ct_roll_denominator :
					_ct_denominator
			}
		);

	return is_struct(
		_stct_world_event
	);
}
