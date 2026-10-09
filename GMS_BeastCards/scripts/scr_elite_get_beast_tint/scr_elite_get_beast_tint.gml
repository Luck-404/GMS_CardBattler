//===============================================================================//
//
// FUNCTION: SCR_ELITE_GET_BEAST_TINT
// FUNCTION: Returns the Beast sprite tint supplied by Elite presentation.
//
//           BATTLE PRIORITY:
//           - GOLDEN / HARDY modifier tint overrides form tint.
//           - Other Elite modifiers return the supplied fallback tint.
//           - The fallback is expected to already resolve Abyssal Form over
//             Frostform through SCR_BATTLE_REFRESH_BEAST_FORM_DRAW.
//
//           OVERWORLD:
//           - GOLDEN uses gold.
//           - All other visible wild Elites use the shared slight-gray tint.
//
// INPUTS:   _str_modifier - Elite modifier ID.
//           _str_context - BATTLE or OVERWORLD.
//           _c_fallback - Tint to preserve when the modifier has no override.
//
//===============================================================================//
function scr_elite_get_beast_tint(_str_modifier,_str_context="BATTLE",_c_fallback=c_white){

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

	//=====================//
	//MODIFIER OVERRIDES//
	//=====================//
	switch (_str_modifier){

		case "GOLDEN":
			return make_colour_rgb(
				255,
				205,
				65
			);

		case "HARDY":
			return make_colour_rgb(
				190,
				190,
				190
			);
	}

	//================//
	//OVERWORLD BASE//
	//================//
	if (_str_context == "OVERWORLD"){
		return make_colour_rgb(
			190,
			190,
			190
		);
	}

	//================//
	//BATTLE FALLBACK//
	//================//
	return _c_fallback;
}
