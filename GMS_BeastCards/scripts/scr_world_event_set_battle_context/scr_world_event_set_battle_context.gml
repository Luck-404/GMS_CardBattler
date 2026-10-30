//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_SET_BATTLE_CONTEXT
// FUNCTION: Installs one battle context on the persistent World Event controller
//           after the overworld encounter successfully claims the battle
//           transition. Captures source position and exact enemy UIDs.
//
// ARGUMENTS: _stct_context - Context created by the battle-context helper.
//            _arr_enemy_units - Exact enemy roster.
// RETURNS: True when installed.
//
//===============================================================================//

function scr_world_event_set_battle_context(
	_stct_context,
	_arr_enemy_units
){

	var _ref_controller =
		scr_world_event_get_controller();

	if (
		!instance_exists(
			_ref_controller
		) ||
		!is_struct(
			_stct_context
		) ||
		!scr_battle_validate_exact_enemy_roster(
			_arr_enemy_units
		)
	){
		return false;
	}

	//================//
	//NORMALIZE FIELDS//
	//================//
	if (
		!variable_struct_exists(
			_stct_context,
			"_uid_world_event"
		)
	){
		_stct_context._uid_world_event = -1;
	}

	if (
		!variable_struct_exists(
			_stct_context,
			"_str_event_id"
		)
	){
		_stct_context._str_event_id = "";
	}

	if (
		!variable_struct_exists(
			_stct_context,
			"_uid_world_event_entity"
		)
	){
		_stct_context._uid_world_event_entity = -1;
	}

	if (
		!variable_struct_exists(
			_stct_context,
			"_uid_world_event_pod"
		)
	){
		_stct_context._uid_world_event_pod = -1;
	}

	if (
		!variable_struct_exists(
			_stct_context,
			"_str_encounter_type"
		)
	){
		_stct_context._str_encounter_type = "SCRIPTED";
	}

	if (
		!variable_struct_exists(
			_stct_context,
			"_flag_suppress_world_event_roll"
		)
	){
		_stct_context._flag_suppress_world_event_roll = true;
	}

	//================//
	//RESET RUN STATE//
	//================//
	_stct_context._flag_active = true;

	_stct_context._rm_source =
		room;

	_stct_context._str_source_room_name =
		string_upper(
			room_get_name(
				room
			)
		);

	_stct_context._val_source_x =
		instance_exists(
			obj_player
		)
		? obj_player.x
		: 0;

	_stct_context._val_source_y =
		instance_exists(
			obj_player
		)
		? obj_player.y
		: 0;

	_stct_context._arr_enemy_uids = [];
	_stct_context._arr_captured_enemy_uids = [];

	_stct_context._str_result = "";
	_stct_context._flag_result_resolved = false;

	for (
		var _it_unit = 0;
		_it_unit <
			array_length(
				_arr_enemy_units
			);
		_it_unit++
	){

		array_push(
			_stct_context
				._arr_enemy_uids,
			_arr_enemy_units[
				_it_unit
			]
			._uid_beast
		);
	}

	_ref_controller._stct_battle_context =
		_stct_context;

	//========================//
	//MARK EVENT BATTLE ACTIVE//
	//========================//
	if (
		_stct_context
			._uid_world_event >=
		0 &&
		is_struct(
			_ref_controller
				._stct_active_world_event
		) &&
		_ref_controller
			._stct_active_world_event
			._uid_world_event ==
		_stct_context
			._uid_world_event
	){

		_ref_controller
			._stct_active_world_event
			._flag_event_battle_active =
			true;
	}

	scr_debug_log(
		"WORLD_EVENT",
		"BATTLE",
		_ref_controller,
		"BATTLE CONTEXT INSTALLED" +
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
		" | TYPE: " +
		string_upper(
			string(
				_stct_context
					._str_encounter_type
			)
		) +
		" | ENEMIES: " +
		string(
			array_length(
				_stct_context
					._arr_enemy_uids
			)
		),
		"INFO",
		"SCR_WORLD_EVENT_SET_BATTLE_CONTEXT"
	);

	return true;
}
