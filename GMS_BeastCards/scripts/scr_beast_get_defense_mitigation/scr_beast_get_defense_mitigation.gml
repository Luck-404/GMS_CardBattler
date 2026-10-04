//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_DEFENSE_MITIGATION
// FUNCTION: Converts raw PHYDEF or MAGDEF into direct damage mitigation.
//
//           0 DEF   = 0% mitigation.
//           300 DEF = 80% mitigation.
//
//           Values above 300 receive diminishing returns toward 100% without
//           reaching a hard mitigation cap at any finite Stat value.
//
// ARGUMENTS: _val_defense - Raw or effective PHYDEF/MAGDEF.
// RETURNS: Mitigation as a decimal from 0 toward 1.
//
//===============================================================================//

function scr_beast_get_defense_mitigation(_val_defense){

	#region VALIDATION

	//==================//
	//SANITIZE DEFENSE//
	//==================//
	if (!is_real(_val_defense)){
		return 0;
	}

	_val_defense = max(0,_val_defense);

	#endregion

	#region STANDARD DEFENSE

	//================//
	//0-300 DEFENSE//
	//================//
	if (_val_defense <= 300){

		return 0.80 * (
			_val_defense /
			300
		);
	}

	#endregion

	#region EX DEFENSE

	//================//
	//EXCESS DEFENSE//
	//================//
	var _val_excess_defense =
		_val_defense -
		300;

	//=======================//
	//DIMINISHING MITIGATION//
	//=======================//
	return 0.80 + (
		0.20 *
		(
			_val_excess_defense /
			(
				_val_excess_defense +
				300
			)
		)
	);

	#endregion
}