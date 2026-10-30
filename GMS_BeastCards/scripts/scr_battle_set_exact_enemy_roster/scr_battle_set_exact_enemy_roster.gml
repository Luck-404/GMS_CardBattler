//===============================================================================//
//
// SCRIPT: SCR_BATTLE_SET_EXACT_ENEMY_ROSTER
// FUNCTION: Stores a validated exact enemy roster for the next battle room.
//           Struct references are preserved; no Beast is regenerated here.
//
// ARGUMENTS: _arr_enemy_units - 1-5 fully initialized Beast structs.
// RETURNS: True when the pending exact roster is stored.
//
//===============================================================================//

function scr_battle_set_exact_enemy_roster(_arr_enemy_units){

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

	global.arr_exact_enemy_roster =
		_arr_exact_enemy_roster;

	global.flag_exact_enemy_roster_pending =
		true;

	// Exact composition and the legacy forced-slot-0 path are mutually exclusive.
	if (
		variable_global_exists(
			"stct_forced_enemy_unit"
		)
	){
		global.stct_forced_enemy_unit =
			undefined;
	}

	scr_debug_log(
		"BATTLE",
		"ROSTER",
		undefined,
		"EXACT ENEMY ROSTER STORED" +
		" | UNITS: " +
		string(
			array_length(
				_arr_exact_enemy_roster
			)
		),
		"INFO",
		"SCR_BATTLE_SET_EXACT_ENEMY_ROSTER"
	);

	return true;
}
