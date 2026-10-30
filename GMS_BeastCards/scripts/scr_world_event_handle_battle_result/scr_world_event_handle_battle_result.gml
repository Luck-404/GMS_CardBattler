//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_HANDLE_BATTLE_RESULT
// FUNCTION: Central World Event exact-battle result dispatch point.
//
//           Phase IV adds Migration pod resolution:
//           - WIN permanently resolves the engaged pod.
//           - LOSS leaves the pod unresolved.
//           - successful captures are permanently removed from that pod even
//             when the player loses the battle.
//
// ARGUMENTS: _stct_context - Resolved battle context.
// RETURNS: True when a valid context was handled.
//
//===============================================================================//

function scr_world_event_handle_battle_result(_stct_context){

	var _ref_controller =
		scr_world_event_get_controller();

	if (
		!instance_exists(
			_ref_controller
		) ||
		!is_struct(
			_stct_context
		)
	){
		return false;
	}

	var _flag_event_context =
		_stct_context
			._uid_world_event >=
		0;

	//====================//
	//WORLD EVENT CONTEXT//
	//====================//
	if (_flag_event_context){

		if (
			!is_struct(
				_ref_controller
					._stct_active_world_event
			) ||
			_ref_controller
				._stct_active_world_event
				._uid_world_event !=
			_stct_context
				._uid_world_event
		){

			scr_debug_log(
				"WORLD_EVENT",
				"BATTLE",
				_ref_controller,
				"WORLD EVENT BATTLE RESULT CONTEXT MISMATCH" +
				" | CONTEXT UID: " +
				string(
					_stct_context
						._uid_world_event
				) +
				" | ACTIVE UID: " +
				(
					is_struct(
						_ref_controller
							._stct_active_world_event
					)
					? string(
						_ref_controller
							._stct_active_world_event
							._uid_world_event
					)
					: "NONE"
				),
				"WARNING",
				"SCR_WORLD_EVENT_HANDLE_BATTLE_RESULT"
			);

			return false;
		}

		_ref_controller
			._stct_active_world_event
			._flag_event_battle_active =
			false;

		if (
			!is_struct(
				_ref_controller
					._stct_active_world_event
					._stct_payload
			)
		){
			_ref_controller
				._stct_active_world_event
				._stct_payload = {};
		}

		_ref_controller
			._stct_active_world_event
			._stct_payload
			._stct_last_battle_context =
			_stct_context;

		//=======================//
		//EVENT-SPECIFIC DISPATCH//
		//=======================//
		switch (
			string_upper(
				string(
					_stct_context
						._str_event_id
				)
			)
		){

			case "MIGRATION":

				if (
					string_upper(
						string(
							_stct_context
								._str_encounter_type
						)
					) ==
					"MIGRATION_POD"
				){

					if (
						!scr_world_event_migration_handle_battle_result(
							_stct_context
						)
					){

						scr_debug_log(
							"WORLD_EVENT",
							"MIGRATION",
							_ref_controller,
							"MIGRATION BATTLE RESULT DISPATCH FAILED" +
							" | POD UID: " +
							string(
								_stct_context
									._uid_world_event_pod
							) +
							" | RESULT: " +
							_stct_context
								._str_result,
							"ERROR",
							"SCR_WORLD_EVENT_HANDLE_BATTLE_RESULT"
						);
					}
				}

			break;

			case "ELITE_SIGHTING":

				if (
					string_upper(
						string(
							_stct_context
								._str_encounter_type
						)
					) ==
					"ELITE_SIGHTING"
				){

					if (
						!scr_world_event_elite_sighting_handle_battle_result(
							_stct_context
						)
					){

						scr_debug_log(
							"WORLD_EVENT",
							"ELITE_SIGHTING",
							_ref_controller,
							"ELITE SIGHTING BATTLE RESULT DISPATCH FAILED" +
							" | ENTITY UID: " +
							string(
								_stct_context
									._uid_world_event_entity
							) +
							" | RESULT: " +
							_stct_context
								._str_result,
							"ERROR",
							"SCR_WORLD_EVENT_HANDLE_BATTLE_RESULT"
						);
					}
				}

			break;
		}
	}

	//================//
	//DEBUG RESULT//
	//================//
	scr_debug_log(
		"WORLD_EVENT",
		"BATTLE",
		_ref_controller,
		"EXACT BATTLE RESULT HANDOFF" +
		" | RESULT: " +
		_stct_context
			._str_result +
		" | EVENT UID: " +
		string(
			_stct_context
				._uid_world_event
		) +
		" | EVENT: " +
		string_upper(
			string(
				_stct_context
					._str_event_id
			)
		) +
		" | ENTITY UID: " +
		string(
			_stct_context
				._uid_world_event_entity
		) +
		" | POD UID: " +
		string(
			_stct_context
				._uid_world_event_pod
		) +
		" | CAPTURES: " +
		string(
			array_length(
				_stct_context
					._arr_captured_enemy_uids
			)
		),
		"INFO",
		"SCR_WORLD_EVENT_HANDLE_BATTLE_RESULT"
	);

	return true;
}
