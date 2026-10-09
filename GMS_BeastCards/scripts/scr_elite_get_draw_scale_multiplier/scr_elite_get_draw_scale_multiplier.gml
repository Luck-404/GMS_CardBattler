//===============================================================================//
//
// FUNCTION: SCR_ELITE_GET_DRAW_SCALE_MULTIPLIER
// FUNCTION: Returns the final Elite-only Beast scale multiplier.
//
//           BATTLE:
//           - Default Elite: 1.40x.
//           - HARDY: 1.70x.
//           - MONARCH: 1.60x.
//
//           OVERWORLD:
//           - Default Elite: 1.60x.
//           - HARDY: 2.00x.
//           - MONARCH: 1.75x.
//
//===============================================================================//
function scr_elite_get_draw_scale_multiplier(_str_modifier,_str_context="BATTLE"){

	_str_modifier =
		string_upper(
			string(
				_str_modifier
			)
		);

	_str_context =
		string_upper(
			string(
				_str_context
			)
		);

	//================//
	//OVERWORLD SCALE//
	//================//
	if (_str_context == "OVERWORLD"){

		switch (_str_modifier){

			case "HARDY":
				return 2.00;

			case "MONARCH":
				return 1.75;
		}

		return 1.60;
	}

	//==============//
	//BATTLE SCALE//
	//==============//
	switch (_str_modifier){

		case "HARDY":
			return 1.70;

		case "MONARCH":
			return 1.60;
	}

	return 1.40;
}
