//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_EXP_REQUIRED
// FUNCTION: Returns the EXP required for a Beast at the supplied Level to gain
//           its next Level.
//
// LEVEL BANDS:
//           1-5   = 10 EXP
//           6-10  = 25 EXP
//           11-15 = 50 EXP
//           16-20 = 100 EXP
//           21-25 = 150 EXP
//           26-29 = 200 EXP
//           30    = 0 / MAX LEVEL
//
// ARGUMENTS: _val_beast_level - Current Beast Level.
// RETURNS: Required EXP, or 0 when already at the Level cap.
//
//===============================================================================//

function scr_beast_get_exp_required(_val_beast_level){

	#region VARIABLES

	_val_beast_level =
		clamp(
			floor(
				_val_beast_level
			),
			1,
			30
		);

	#endregion

	#region EXP REQUIREMENT

	if (_val_beast_level <= 5){
		return 10;
	}

	if (_val_beast_level <= 10){
		return 25;
	}

	if (_val_beast_level <= 15){
		return 50;
	}

	if (_val_beast_level <= 20){
		return 100;
	}

	if (_val_beast_level <= 25){
		return 150;
	}

	if (_val_beast_level < 30){
		return 200;
	}

	#endregion

	return 0;
}