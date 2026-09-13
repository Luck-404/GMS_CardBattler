//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_MAX_HP
// FUNCTION: Calculates a Beast's maximum HP from its HP stat and level.
//           Uses the Beast's grade modifier to determine HP gained per level.
//           Clamps level between 1 and the maximum level of 30.
//
// ARGUMENTS: _val_hp_stat is the Beast's HP stat and _val_level is its level.
// RETURNS: The calculated maximum HP, with a minimum value of 1.
//
//===============================================================================//

function scr_beast_get_max_hp(_val_hp_stat,_val_level){

	//================//
	//VALIDATE LEVEL//
	//================//
	_val_level = clamp(_val_level,1,30);

	//===================//
	//CALCULATE HP GROWTH//
	//===================//
	var _val_hp_modifier = scr_beast_get_grade_modifier(_val_hp_stat);
	var _val_hp_per_level = 5 + (5 * _val_hp_modifier);
	var _val_max_hp = ceil(10 + (_val_hp_per_level * _val_level));

	return max(1,_val_max_hp);
}