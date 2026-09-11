//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_HEAL_LINEAR_AMOUNT
// FUNCTION: Calculates a linearly scaled healing value.
//           PHY healing scales from the caster's PPOW and MAG healing scales
//           from the caster's MPOW. Does not restore HP.
//
// INPUTS:   _val_amount - Base healing amount before linear scaling.
//           _ref_caster - Battle Beast supplying the Power stat.
//           _stct_card - Card struct determining which Power stat is used.
// USES:     Caster Beast stats and shared Beast grade-modifier calculation.
//
//===============================================================================//

function scr_battle_get_heal_linear_amount(_val_amount,_ref_caster,_stct_card){

	#region VALIDATION

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
	if (_val_amount <= 0){
		return 0;
	}

	//-----------------//
	//VALIDATE CASTER//
	//-----------------//
	if (!instance_exists(_ref_caster)){
		return 0;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return 0;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	if (!is_struct(_stct_card)){
		return 0;
	}

	#endregion

	#region HEAL SCALING

	//-----------------//
	//GET CASTER UNIT//
	//-----------------//
	var _stct_caster_unit = _ref_caster._ref_unit;
	var _val_healing = _val_amount;

	//---------------//
	//PHYPOW SCALING//
	//---------------//
	if (_stct_card._str_card_stat == "PHY"){

		var _val_ppow_modifier = scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_ppow_stat);

		_val_healing *= _val_ppow_modifier;
	}

	//---------------//
	//MAGPOW SCALING//
	//---------------//
	else if (_stct_card._str_card_stat == "MAG"){

		var _val_mpow_modifier = scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_mpow_stat);

		_val_healing *= _val_mpow_modifier;
	}

	#endregion

	return max(0,ceil(_val_healing));
}