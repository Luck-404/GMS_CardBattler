//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_STAT_PREVIEW
// FUNCTION: Converts a Beast stat into a five-level battle preview rating.
//           Returns --, -, o, +, or ++ and can invert that rating for
//           defensive or resistance target previews.
//
// INPUTS:   _val_stat - Beast stat value being converted into a preview rating.
//           _flag_invert - Whether the resulting rating should be reversed.
// USES:     Shared Beast grade-modifier calculation.
//
//===============================================================================//

function scr_battle_get_stat_preview(_val_stat,_flag_invert){

	#region STAT RATING

	//-------------------//
	//GET GRADE MODIFIER//
	//-------------------//
	var _val_grade_modifier = scr_beast_get_grade_modifier(_val_stat);
	var _str_rating = "o";

	//----------------//
	//CALCULATE RATING//
	//----------------//
	if (_val_grade_modifier <= 0.6){
		_str_rating = "--";
	}
	else if (_val_grade_modifier <= 0.9){
		_str_rating = "-";
	}
	else if (_val_grade_modifier <= 1.2){
		_str_rating = "o";
	}
	else if (_val_grade_modifier <= 1.6){
		_str_rating = "+";
	}
	else{
		_str_rating = "++";
	}

	#endregion

	#region INVERT RATING

	//-------------------//
	//INVERT TARGET VALUE//
	//-------------------//
	if (_flag_invert){

		switch(_str_rating){

			case "--":
				return "++";

			case "-":
				return "+";

			case "o":
				return "o";

			case "+":
				return "-";

			case "++":
				return "--";
		}
	}

	#endregion

	return _str_rating;
}