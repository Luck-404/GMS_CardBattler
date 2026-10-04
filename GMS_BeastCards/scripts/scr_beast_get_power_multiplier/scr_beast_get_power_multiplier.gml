//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_POWER_MULTIPLIER
// FUNCTION: Converts a raw PHYPOW or MAGPOW Stat into its direct scaling
//           multiplier.
//
//           0   = 0.0x
//           50  = 0.5x
//           100 = 1.0x
//           150 = 1.5x
//           200 = 2.0x
//           250 = 2.5x
//           300 = 3.0x
//
//           Values above 300 continue scaling without a hard cap.
//
// ARGUMENTS: _val_power - Raw or effective PHYPOW/MAGPOW.
// RETURNS: Power multiplier.
//
//===============================================================================//

function scr_beast_get_power_multiplier(_val_power){

	#region VALIDATION

	//================//
	//SANITIZE POWER//
	//================//
	if (!is_real(_val_power)){
		return 0;
	}

	_val_power = max(0,_val_power);

	#endregion

	#region MULTIPLIER

	//==================//
	//POWER MULTIPLIER//
	//==================//
	return _val_power / 100;

	#endregion
}