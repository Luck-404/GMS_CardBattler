//===============================================================================//
//
// SCRIPT: SCR_ENCOUNTER_ROLL_DIFFICULTY
// FUNCTION: Rolls the base difficulty of a normal wild encounter.
//
// CURRENT WEIGHTS:
//
//           EASY   = 25%
//           MEDIUM = 55%
//           HARD   = 20%
//
//           ELITE is intentionally NOT active yet.
//
//           Difficulty modifies the encounter produced by normal Party-count,
//           owned-average-Level, and zone-Level scaling. It does not replace
//           those systems.
//
// RETURNS: "EASY", "MEDIUM", or "HARD".
//
//===============================================================================//

function scr_encounter_roll_difficulty(){

	#region VARIABLES

	//================//
	//DIFFICULTY WEIGHTS//
	//================//

	var _val_weight_easy = 25;
	var _val_weight_medium = 55;
	var _val_weight_hard = 20;

	//===============================================================================
	// FUTURE: ELITE ENCOUNTERS
	//===============================================================================
	//
	// Elite encounters are intentionally disabled for now.
	//
	// Eventually:
	//
	// var _val_weight_elite = 5;
	//
	// Elite Beasts will use an encounter-slot budget rather than behaving like
	// ordinary enemies. One Elite may consume one or multiple normal enemy slots
	// depending on its power and special effects.
	//
	// ELITE should be more dangerous than HARD, but remain below the complexity
	// and scripting of a miniboss or boss encounter.
	//
	//===============================================================================//

	var _val_weight_total =
		_val_weight_easy +
		_val_weight_medium +
		_val_weight_hard;

	var _val_roll =
		irandom_range(
			1,
			_val_weight_total
		);

	#endregion

	#region RESULT

	//================//
	//EASY//
	//================//

	if (_val_roll <= _val_weight_easy){
		return "EASY";
	}

	//================//
	//MEDIUM//
	//================//

	_val_roll -= _val_weight_easy;

	if (_val_roll <= _val_weight_medium){
		return "MEDIUM";
	}

	//================//
	//HARD//
	//================//

	return "HARD";

	//===============================================================================
	// FUTURE: ELITE
	//===============================================================================
	//
	// Once Elite encounters are implemented, add their weight to
	// _val_weight_total and return "ELITE" from the final weighted branch.
	//
	//===============================================================================//

	#endregion
}