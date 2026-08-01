//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_MAX_HP
// FUNCTION: Calculates a Beast's maximum HP from its HP stat and level.
//           Uses the Beast's grade modifier to determine HP gained per level.
//           Clamps level between 1 and the maximum level of 30.
//
//===============================================================================//

function scr_get_beast_max_hp(_val_hp_stat,_val_level){

	//----------------//
	//VALIDATE LEVEL//
	//----------------//
	_val_level = clamp(_val_level,1,30);

	//-----------------//
	//GET HP MODIFIER//
	//-----------------//
	var _val_hp_modifier =
		scr_get_beast_grade_modifier(_val_hp_stat);

	//--------------------//
	//CALCULATE HP GROWTH//
	//--------------------//
	var _val_hp_per_level =
		5 +
		(5 * _val_hp_modifier);

	//--------------------//
	//CALCULATE MAXIMUM HP//
	//--------------------//
	var _val_max_hp = ceil(
		10 +
		(_val_hp_per_level * _val_level)
	);

	return max(1,_val_max_hp);
}