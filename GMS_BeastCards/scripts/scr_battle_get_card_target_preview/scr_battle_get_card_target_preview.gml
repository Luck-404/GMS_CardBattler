//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_TARGET_PREVIEW
// FUNCTION: Returns the selected Card's five-level target effectiveness preview.
//
//           Direct PHY Cards evaluate target PHYDEF.
//           Direct MAG Cards evaluate target MAGDEF.
//           DoTs, Debuffs, and CC evaluate target CON.
//           Defensive/resistance values are inverted because higher target
//           resistance makes the Card less effective.
//
//           Direct NEU Attacks are always NEUTRAL.
//
// ARGUMENTS: _stct_card - Card being previewed.
//            _ref_target - Battle Beast being evaluated as target.
// RETURNS: VERY WEAK, WEAK, NEUTRAL, STRONG, VERY STRONG, or "".
//
//===============================================================================//

function scr_battle_get_card_target_preview(_stct_card,_ref_target){

	#region VALIDATION

	//----------------//
	//VALIDATE CARD//
	//----------------//
	if (!is_struct(_stct_card)){
		return "";
	}

	//----------------//
//VALIDATE TARGET//
//----------------//
	if (!instance_exists(_ref_target)){
		return "";
	}

	if (!is_struct(_ref_target._ref_unit)){
		return "";
	}

	#endregion

	#region TARGET PREVIEW

	var _stct_target_unit =
		_ref_target._ref_unit;

	var _str_effect_type =
		_stct_card._str_card_effect_type;

	//------------------//
	//CONSTITUTION CHECK//
	//------------------//
	if (
		_str_effect_type == "DOT" ||
		_str_effect_type == "DEBUFF" ||
		_str_effect_type == "CC"
	){

		return scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_con_stat,
			true
		);
	}

	//---------------//
	//DIRECT PHYSICAL//
	//---------------//
	if (
		_str_effect_type == "DIRECT" &&
		_stct_card._str_card_stat == "PHY"
	){

		return scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_pdef_stat,
			true
		);
	}

	//--------------//
	//DIRECT MAGICAL//
	//--------------//
	if (
		_str_effect_type == "DIRECT" &&
		_stct_card._str_card_stat == "MAG"
	){

		return scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_mdef_stat,
			true
		);
	}

	//--------------//
	//DIRECT NEUTRAL//
	//--------------//
	if (
		_str_effect_type == "DIRECT" &&
		_stct_card._str_card_stat == "NEU"
	){
		return "NEUTRAL";
	}

	#endregion

	return "";
}