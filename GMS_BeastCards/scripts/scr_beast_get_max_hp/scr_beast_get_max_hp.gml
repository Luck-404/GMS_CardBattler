//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_MAX_HP
// FUNCTION: Calculates a Beast's maximum HP from its HP Stat and Level.
//
//           Every Beast gains a guaranteed 10 HP per Level.
//           The HP Stat modifies an additional 5 HP per Level.
//
//           HP Stat 0   = 10 HP per Level.
//           HP Stat 100 = 15 HP per Level.
//           HP Stat 200 = 20 HP per Level.
//           HP Stat 300 = 25 HP per Level.
//
// ARGUMENTS: _val_hp_stat - Beast HP Stat.
//            _val_level - Beast Level.
// RETURNS: Calculated maximum HP.
//
//===============================================================================//

function scr_beast_get_max_hp(_val_hp_stat,_val_level){

	#region VALIDATION

	//================//
//SANITIZE HP STAT//
//================//
	_val_hp_stat = max(
		0,
		_val_hp_stat
	);

	//================//
	//SANITIZE LEVEL//
	//================//
	_val_level = max(
		1,
		floor(_val_level)
	);

	#endregion

	#region MAXIMUM HP

	//================//
	//LEVEL HP GROWTH//
	//================//
	var _val_hp_growth =
		scr_beast_get_hp_level_growth(
			_val_hp_stat
		);

	//================//
	//CALCULATE HP//
	//================//
	var _val_max_hp =
		10 +
		(
			_val_hp_growth *
			_val_level
		);

	return ceil(
		_val_max_hp
	);

	#endregion
}