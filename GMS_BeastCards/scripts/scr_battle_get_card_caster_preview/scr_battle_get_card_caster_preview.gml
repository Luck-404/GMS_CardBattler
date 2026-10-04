//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_CASTER_PREVIEW
// FUNCTION: Returns the selected Card's five-level caster effectiveness preview.
//
//           PHY Cards evaluate the caster's PHYPOW.
//           MAG Cards evaluate the caster's MAGPOW.
//           NEU Attacks are always NEUTRAL.
//
//           DoT, Debuff, and CC effects do not use an offensive Power preview.
//
// ARGUMENTS: _stct_card - Card being previewed.
//            _ref_caster - Battle Beast being evaluated as caster.
// RETURNS: VERY WEAK, WEAK, NEUTRAL, STRONG, VERY STRONG, or "".
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
	var _str_effect_type =
		_stct_card._str_card_effect_type;

	//---------------------//
	//NO POWER PREVIEW//
	//---------------------//
	if (
		_str_effect_type == "DOT" ||
		_str_effect_type == "DEBUFF" ||
		_str_effect_type == "CC"
	){
		return "";
	}

	//----------------//
	//PHYSICAL POWER//
	//----------------//
	if (_stct_card._str_card_stat == "PHY"){

		return scr_battle_get_stat_preview(
			_ref_caster._ref_unit._val_beast_ppow_stat,
			false
		);
	}

	//---------------//
	//MAGICAL POWER//
	//---------------//
	if (_stct_card._str_card_stat == "MAG"){

		return scr_battle_get_stat_preview(
			_ref_caster._ref_unit._val_beast_mpow_stat,
			false
		);
	}

	//----------------//
	//NEUTRAL ATTACK//
	//----------------//
	if (
		_stct_card._str_card_stat == "NEU" &&
		_stct_card._str_card_type == "ATTACK"
	){
		return "NEUTRAL";
	}

	#endregion

	return "";
}