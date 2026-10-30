//===============================================================================//
//
// SCRIPT: SCR_BATTLE_CLEAR_EXACT_ENEMY_ROSTER
// FUNCTION: Clears only the transition-global exact-roster handoff.
//
// RETURNS: Nothing.
//
//===============================================================================//

function scr_battle_clear_exact_enemy_roster(){

	global.arr_exact_enemy_roster = [];
	global.flag_exact_enemy_roster_pending = false;
}
