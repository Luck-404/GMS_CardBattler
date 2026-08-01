//===============================================================================//
//
// SCRIPT: SCR_GET_CARD_CASTER_PREVIEW
// FUNCTION: Returns the selected card's relevant offensive stat preview.
//           PHY cards inspect PPOW.
//           MAG cards inspect MPOW.
//           Returns an empty string when caster power is not relevant.
//
//===============================================================================//

function scr_get_card_caster_preview(_stct_card,_ref_caster){

	if (_stct_card == undefined){
		return "";
	}

	if (!instance_exists(_ref_caster)){
		return "";
	}

	// DOT / DEBUFF / CC CURRENTLY DO NOT NEED
	// A CASTER POWER PREVIEW.
	if (
		_stct_card._str_card_effect_type == "DOT" ||
		_stct_card._str_card_effect_type == "DEBUFF" ||
		_stct_card._str_card_effect_type == "CC"
	){
		return "";
	}

	switch(_stct_card._str_card_stat){

		case "PHY":

			return "PHY " + scr_get_battle_stat_preview(
				_ref_caster._ref_unit._val_beast_ppow_stat,
				false
			);

		case "MAG":

			return "MAG " + scr_get_battle_stat_preview(
				_ref_caster._ref_unit._val_beast_mpow_stat,
				false
			);
	}

	return "";
}