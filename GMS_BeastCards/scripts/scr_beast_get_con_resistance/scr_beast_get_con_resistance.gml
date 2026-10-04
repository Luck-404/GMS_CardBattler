//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_CON_RESISTANCE
// FUNCTION: Converts raw CON into Status resistance chance.
//
//           0 CON   = 0% resistance.
//           300 CON = 50% resistance.
//
//           Values above 300 receive diminishing returns toward 100% without
//           reaching a hard resistance cap at any finite Stat value.
//
// ARGUMENTS: _val_con - Raw or effective CON.
// RETURNS: Resistance chance from 0 toward 100.
//
//===============================================================================//

function scr_beast_get_con_resistance(_val_con){

	#region VALIDATION

	//==============//
	//SANITIZE CON//
	//==============//
	if (!is_real(_val_con)){
		return 0;
	}

	_val_con = max(0,_val_con);

	#endregion

	#region STANDARD CON

	//===========//
	//0-300 CON//
	//===========//
	if (_val_con <= 300){

		return 50 * (
			_val_con /
			300
		);
	}

	#endregion

	#region EX CON

	//============//
	//EXCESS CON//
	//============//
	var _val_excess_con =
		_val_con -
		300;

	//=======================//
	//DIMINISHING RESISTANCE//
	//=======================//
	return 50 + (
		50 *
		(
			_val_excess_con /
			(
				_val_excess_con +
				300
			)
		)
	);

	#endregion
}