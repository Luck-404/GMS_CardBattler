//===============================================================================//
//
// SCRIPT: SCR_GET_BATTLE_STAT_PREVIEW
// FUNCTION: Converts a beast stat into a five-level battle preview rating.
//           Returns --, -, o, +, or ++.
//           Can invert the result for defensive/resistance target previews.
//
//===============================================================================//

function scr_get_battle_stat_preview(_val_stat,_flag_invert){

	var _val_mod = scr_get_beast_grade_modifier(_val_stat);
	var _str_rating = "o";

	if (_val_mod <= 0.6){
		_str_rating = "--";
	}
	else if (_val_mod <= 0.9){
		_str_rating = "-";
	}
	else if (_val_mod <= 1.2){
		_str_rating = "o";
	}
	else if (_val_mod <= 1.6){
		_str_rating = "+";
	}
	else{
		_str_rating = "++";
	}

	// TARGET DEFENSE IS INVERTED:
	// LOW DEFENSE = GOOD TARGET
	// HIGH DEFENSE = BAD TARGET
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

	return _str_rating;
}