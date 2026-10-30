//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_COMPLETE
// FUNCTION: Resolves the premium World Event completion reward once, marks the
//           current ACTIVE event completed, and starts its completion hold.
//           Migration uses its short cleared-state display; later events retain
//           the generic completion/reward grace until their own cleanup rules exist.
//
// ARGUMENTS: _str_source - Optional completion source for debug output.
// RETURNS: True when the event changes to COMPLETED.
//
//===============================================================================//

function scr_world_event_complete(_str_source="EVENT OBJECTIVE"){

	var _ref_controller =
		scr_world_event_get_controller();

	if (!instance_exists(_ref_controller)){
		return false;
	}

	var _stct_world_event =
		_ref_controller
			._stct_active_world_event;

	if (
		!is_struct(
			_stct_world_event
		) ||
		_stct_world_event
			._state_world_event !=
		ENUM_WORLD_EVENT_STATE.ACTIVE
	){
		return false;
	}

	//========================//
	//PREMIUM COMPLETION REWARD//
	//========================//
	var _stct_premium_reward =
		scr_world_event_reward_resolve(
			_stct_world_event
		);

	var _flag_premium_reward_awarded =
		is_struct(_stct_premium_reward) &&
		variable_struct_exists(
			_stct_premium_reward,
			"_flag_success"
		) &&
		_stct_premium_reward._flag_success;

	//================//
	//COMPLETE EVENT//
	//================//
	_stct_world_event
		._state_world_event =
		ENUM_WORLD_EVENT_STATE.COMPLETED;

	_stct_world_event
		._flag_completed =
		true;

	_stct_world_event
		._val_active_time_remaining =
		0;

	var _flag_migration =
		_stct_world_event
			._str_event_id ==
		"MIGRATION";

	var _flag_gilded_gambit =
		_stct_world_event
			._str_event_id ==
		"CHOOSE_A_CHEST";

	var _flag_runaway_treasure =
		_stct_world_event
			._str_event_id ==
		"RUNAWAY_TREASURE_BEAST";

	var _flag_elite_sighting =
		_stct_world_event
			._str_event_id ==
		"ELITE_SIGHTING";

	if (_flag_migration){

		_stct_world_event
			._val_cleanup_time_remaining =
			_ref_controller
				._val_migration_completion_display_seconds;
	}
	else if (_flag_gilded_gambit){

		_stct_world_event
			._val_cleanup_time_remaining =
			_ref_controller
				._val_gilded_gambit_completion_display_seconds;
	}
	else if (_flag_runaway_treasure){

		// The Beast is already caught, but its burst treasure sparkles remain
		// collectible during the normal completion grace.
		_stct_world_event
			._val_cleanup_time_remaining =
			_ref_controller
				._val_completion_grace_seconds;
	}
	else if (_flag_elite_sighting){

		_stct_world_event
			._val_cleanup_time_remaining =
			_ref_controller
				._val_elite_sighting_completion_display_seconds;
	}
	else{

		_stct_world_event
			._val_cleanup_time_remaining =
			_ref_controller
				._val_completion_grace_seconds;
	}

	//================//
	//COMPLETION BANNER//
	//================//
	if (_flag_migration){

		scr_world_event_show_banner(
			"WORLD EVENT — MIGRATION CLEARED",
			_flag_premium_reward_awarded
			? "PREMIUM REWARDS AWARDED"
			: _stct_world_event._str_target_room_name,
			"CLEARS IN " +
				scr_world_event_format_time(
					_stct_world_event
						._val_cleanup_time_remaining
				)
		);
	}
	else if (_flag_gilded_gambit){

		scr_world_event_show_banner(
			"WORLD EVENT — GILDED GAMBIT CLEARED",
			_flag_premium_reward_awarded
			? "PREMIUM REWARD CLAIMED"
			: _stct_world_event._str_target_room_name,
			"CLEARS IN " +
				scr_world_event_format_time(
					_stct_world_event
						._val_cleanup_time_remaining
				)
		);
	}
	else if (_flag_runaway_treasure){

		var _ct_sparkles_remaining = 0;

		if (
			is_struct(_stct_world_event._stct_payload) &&
			variable_struct_exists(
				_stct_world_event._stct_payload,
				"_ct_runaway_treasure_sparkles_remaining"
			)
		){
			_ct_sparkles_remaining =
				max(
					0,
					_stct_world_event
						._stct_payload
						._ct_runaway_treasure_sparkles_remaining
				);
		}

		scr_world_event_show_banner(
			"WORLD EVENT — TREASURE BEAST CAUGHT",
			"TREASURE BURST! " +
				string(_ct_sparkles_remaining) +
				" SPARKLES DROPPED",
			"COLLECT THEM | " +
				scr_world_event_format_time(
					_stct_world_event
						._val_cleanup_time_remaining
				)
		);
	}
	else if (_flag_elite_sighting){

		scr_world_event_show_banner(
			"WORLD EVENT — ELITE SIGHTING CLEARED",
			_flag_premium_reward_awarded
			? "TIER 2 ELITE DEFEATED — PREMIUM REWARDS AWARDED"
			: "TIER 2 ELITE DEFEATED",
			"CLEARS IN " +
				scr_world_event_format_time(
					_stct_world_event
						._val_cleanup_time_remaining
				)
		);
	}
	else{

		scr_world_event_show_banner(
			"WORLD EVENT COMPLETE",
			_stct_world_event
				._str_display_name,
			(
				_flag_premium_reward_awarded
				? "PREMIUM REWARDS AWARDED | "
				: ""
			) +
				scr_world_event_format_time(
					_stct_world_event
						._val_cleanup_time_remaining
				)
		);
	}

	//================//
	//DEBUG//
	//================//
	scr_debug_log(
		"WORLD_EVENT",
		"STATE",
		_ref_controller,
		"WORLD EVENT COMPLETED" +
		" | UID: " +
		string(
			_stct_world_event
				._uid_world_event
		) +
		" | EVENT: " +
		_stct_world_event
			._str_event_id +
		" | SOURCE: " +
		string_upper(
			string(
				_str_source
			)
		) +
		" | PREMIUM REWARD: " +
		(
			_flag_premium_reward_awarded
			? "YES"
			: "NO"
		) +
		" | COMPLETION HOLD: " +
		string(
			_stct_world_event
				._val_cleanup_time_remaining
		) +
		" SEC",
		"INFO",
		"SCR_WORLD_EVENT_COMPLETE"
	);

	return true;
}
