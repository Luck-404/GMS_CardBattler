//===============================================================================//
//
// SCRIPT: SCR_BATTLE_ARMOR_TARGET_LINEAR
// FUNCTION: Grants linearly scaled Armor to a target battle Beast.
//           PHY Cards scale from the caster's PPOW and MAG Cards scale from
//           the caster's MPOW before passing the result into standard Armor.
//
// INPUTS:   _val_amount - Base Armor amount before linear scaling.
//           _ref_target - Battle Beast receiving the Armor.
// USES:     Current caster/Card context, Beast grade modifiers, and
//           scr_battle_armor_target for final Armor application.
//
//===============================================================================//

function scr_battle_armor_target_linear(_val_amount,_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	if (_val_amount <= 0){
		return false;
	}

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	var _ref_caster = global.ref_caster_beast;

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (!is_struct(_ref_caster._ref_unit)){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	var _ref_card = global.ref_cast_card;

	if (!instance_exists(_ref_card)){
		return false;
	}

	if (!is_struct(_ref_card._ref_card)){
		return false;
	}

	#endregion

	#region ARMOR SCALING

	//----------------//
	//GET CAST DATA//
	//----------------//
	var _stct_caster_unit = _ref_caster._ref_unit;
	var _stct_card = _ref_card._ref_card;

	var _val_armor = _val_amount;
	var _str_card_stat = _stct_card._str_card_stat;

	//---------------//
	//PHYPOW SCALING//
	//---------------//
	if (_str_card_stat == "PHY"){

		var _val_ppow_modifier = scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_ppow_stat);

		_val_armor = ceil(_val_armor * _val_ppow_modifier);
	}

	//---------------//
	//MAGPOW SCALING//
	//---------------//
	else if (_str_card_stat == "MAG"){

		var _val_mpow_modifier = scr_beast_get_grade_modifier(_stct_caster_unit._val_beast_mpow_stat);

		_val_armor = ceil(_val_armor * _val_mpow_modifier);
	}

	#endregion

	#region ARMOR APPLICATION

	//-------------//
	//GRANT ARMOR//
	//-------------//
	return scr_battle_armor_target(_val_armor,_ref_target);

	#endregion
}