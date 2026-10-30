//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CONSUME_EXACT_ENEMY_ROSTER
// FUNCTION: Returns the pending exact roster once to the enemy battle controller,
//           then clears the transition-global handoff immediately.
//
// RETURNS: Exact roster array or an empty array.
//
//===============================================================================//

function scr_battle_consume_exact_enemy_roster(){

	if (
		!variable_global_exists(
			"flag_exact_enemy_roster_pending"
		) ||
		!global.flag_exact_enemy_roster_pending ||
		!variable_global_exists(
			"arr_exact_enemy_roster"
		) ||
		!scr_battle_validate_exact_enemy_roster(
			global.arr_exact_enemy_roster
		)
	){
		scr_battle_clear_exact_enemy_roster();

		return [];
	}

	var _arr_exact_enemy_roster = [];

	for (
		var _it_unit = 0;
		_it_unit <
			array_length(
				global.arr_exact_enemy_roster
			);
		_it_unit++
	){

		array_push(
			_arr_exact_enemy_roster,
			global.arr_exact_enemy_roster[
				_it_unit
			]
		);
	}

	scr_battle_clear_exact_enemy_roster();

	return _arr_exact_enemy_roster;
}
