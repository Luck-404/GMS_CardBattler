//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_CASTER_PREVIEW
// FUNCTION: Returns the selected Card's relevant offensive-stat preview.
//           PHY Cards inspect PPOW and MAG Cards inspect MPOW.
//           Returns an empty string when caster Power is not relevant.
//
// INPUTS:   _stct_card - Card struct being previewed.
//           _ref_caster - Battle Beast being evaluated as the Card caster.
// USES:     The caster's persistent Beast stats and shared stat-preview helper.
//
//===============================================================================//

function scr_battle_get_card_caster_preview(_stct_card,_ref_caster){

	#region VALIDATION

	//----------------//
	//VALIDATE CARD//
	//----------------//
	if (!is_struct(_stct_card)){
		return "";
	}

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return "";
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return "";
	}

	#endregion

	#region CASTER PREVIEW

	//-----------------//
	//GET EFFECT TYPE//
	//-----------------//
	var _str_effect_type = _stct_card._str_card_effect_type;

	//---------------------//
	//NO POWER PREVIEW//
	//---------------------//
	if (_str_effect_type == "DOT" || _str_effect_type == "DEBUFF" || _str_effect_type == "CC"){
		return "";
	}

	//----------------//
	//GET POWER STAT//
	//----------------//
	switch(_stct_card._str_card_stat){

		case "PHY":
			return "PHY " + scr_battle_get_stat_preview(_ref_caster._ref_unit._val_beast_ppow_stat,false);

		case "MAG":
			return "MAG " + scr_battle_get_stat_preview(_ref_caster._ref_unit._val_beast_mpow_stat,false);
	}

	#endregion

	return "";
}