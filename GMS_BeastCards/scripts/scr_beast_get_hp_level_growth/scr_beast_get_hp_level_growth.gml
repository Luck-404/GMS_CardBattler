//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_HP_LEVEL_GROWTH
// FUNCTION: Returns the Max HP gained from each Beast Level based on the
//           Beast's HP Stat.
//
//           Every Beast gains a guaranteed 10 HP per Level.
//           The HP Stat modifies only the additional bonus growth:
//
//           Bonus HP per Level = 5 * (HP Stat / 100)
//
//           0 HP Stat therefore removes only the bonus portion and never
//           removes the guaranteed 10 HP growth.
//
// ARGUMENTS: _val_hp_stat - Raw Beast HP Stat.
// RETURNS: Max HP growth per Level.
//
//===============================================================================//

function scr_beast_get_hp_level_growth(_val_hp_stat){

	#region VALIDATION

	//================//
//SANITIZE HP STAT//
//================//
	if (!is_real(_val_hp_stat)){
		_val_hp_stat = 0;
	}

	_val_hp_stat = max(0,_val_hp_stat);

	#endregion

	#region HP GROWTH

	//==================//
	//HP STAT MODIFIER//
	//==================//
	var _val_hp_modifier =
		_val_hp_stat /
		100;

	//================//
	//LEVEL HP GROWTH//
	//================//
	return 10 + (
		5 *
		_val_hp_modifier
	);

	#endregion
}