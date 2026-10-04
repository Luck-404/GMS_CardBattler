//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_STAT_PREVIEW
// FUNCTION: Converts a Beast primary Stat into a five-level battle preview.
//
//           0-60    = VERY WEAK
//           61-120  = WEAK
//           121-180 = NEUTRAL
//           181-240 = STRONG
//           241+    = VERY STRONG
//
//           Defensive/resistance previews can invert the result so a high
//           defensive Stat represents a weak matchup for the attacker.
//
// INPUTS:   _val_stat - Beast primary Stat being evaluated.
//           _flag_invert - Whether the resulting preview should be reversed.
// RETURNS:  VERY WEAK, WEAK, NEUTRAL, STRONG, or VERY STRONG.
//
//===============================================================================//

function scr_battle_get_stat_preview(_val_stat,_flag_invert=false){

	#region VALIDATION

	//================//
	//SANITIZE STAT//
	//================//
	if (!is_real(_val_stat)){
		_val_stat = 0;
	}

	_val_stat = max(
		0,
		_val_stat
	);

	#endregion

	#region STAT RATING

	//================//
	//DEFAULT RATING//
	//================//
	var _str_rating = "NEUTRAL";

	//================//
	//CALCULATE RATING//
	//================//
	if (_val_stat <= 60){

		_str_rating =
			"VERY WEAK";
	}
	else if (_val_stat <= 120){

		_str_rating =
			"WEAK";
	}
	else if (_val_stat <= 180){

		_str_rating =
			"NEUTRAL";
	}
	else if (_val_stat <= 240){

		_str_rating =
			"STRONG";
	}
	else{

		_str_rating =
			"VERY STRONG";
	}

	#endregion

	#region INVERT RATING

	//================//
	//INVERT RATING//
	//================//
	if (_flag_invert){

		switch (_str_rating){

			case "VERY WEAK":
				return "VERY STRONG";

			case "WEAK":
				return "STRONG";

			case "NEUTRAL":
				return "NEUTRAL";

			case "STRONG":
				return "WEAK";

			case "VERY STRONG":
				return "VERY WEAK";
		}
	}

	#endregion

	return _str_rating;
}