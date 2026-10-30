//===============================================================================//
//
// SCRIPT: SCR_OVERWORLD_ASSIGN_EXACT_ENEMY_ROSTER
// FUNCTION: Attaches an exact battle roster to a visible overworld Beast.
//           Touching that Beast through the normal wild-battle trigger will hand
//           this exact roster to battle instead of rolling supplemental enemies.
//
//           Phase IV Migration can attach the same pod roster to every visible
//           pod member so touching any member starts the same exact pod battle.
//
// ARGUMENTS: _ref_world_beast - Visible overworld Beast.
//            _arr_enemy_units - 1-5 initialized Beast structs.
//            _stct_world_event_battle_context - Optional persistent battle context.
// RETURNS: True when the roster is attached.
//
//===============================================================================//

function scr_overworld_assign_exact_enemy_roster(
	_ref_world_beast,
	_arr_enemy_units,
	_stct_world_event_battle_context=undefined
){

	if (!instance_exists(_ref_world_beast)){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_world_beast,
			"_stct_unit"
		) ||
		!is_struct(
			_ref_world_beast
				._stct_unit
		)
	){
		return false;
	}

	if (
		!scr_battle_validate_exact_enemy_roster(
			_arr_enemy_units
		)
	){
		return false;
	}

	var _arr_exact_enemy_roster = [];

	for (
		var _it_unit = 0;
		_it_unit <
			array_length(
				_arr_enemy_units
			);
		_it_unit++
	){

		array_push(
			_arr_exact_enemy_roster,
			_arr_enemy_units[
				_it_unit
			]
		);
	}

	_ref_world_beast._arr_exact_enemy_roster =
		_arr_exact_enemy_roster;

	_ref_world_beast._stct_world_event_battle_context =
		is_struct(
			_stct_world_event_battle_context
		)
		? _stct_world_event_battle_context
		: undefined;

	scr_debug_log(
		"WORLD",
		"ENCOUNTER",
		_ref_world_beast,
		"EXACT ENEMY ROSTER ATTACHED" +
		" | VISIBLE BEAST: " +
		string_upper(
			string(
				_ref_world_beast
					._stct_unit
					._str_beast_name
			)
		) +
		" | UNITS: " +
		string(
			array_length(
				_arr_exact_enemy_roster
			)
		) +
		" | WORLD EVENT CONTEXT: " +
		(
			is_struct(
				_stct_world_event_battle_context
			)
			? "YES"
			: "NO"
		),
		"INFO",
		"SCR_OVERWORLD_ASSIGN_EXACT_ENEMY_ROSTER"
	);

	return true;
}
