//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_CARD_TARGET_PREVIEW
// FUNCTION: Returns the target's relevant defensive-stat preview for a Card.
//           Direct PHY Cards inspect PDEF, Direct MAG Cards inspect MDEF,
//           while DoTs, Debuffs, and Crowd Control inspect CON.
//
// INPUTS:   _stct_card - Card struct being previewed.
//           _ref_target - Battle Beast being evaluated as the Card target.
// USES:     Target Beast stats and the shared stat-preview formatter.
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

	//----------------//
	//GET TARGET UNIT//
	//----------------//
	var _stct_target_unit = _ref_target._ref_unit;
	var _str_effect_type = _stct_card._str_card_effect_type;

	//------------------//
	//CONSTITUTION CHECK//
	//------------------//
	if (_str_effect_type == "DOT" || _str_effect_type == "DEBUFF" || _str_effect_type == "CC"){

		return "CON " + scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_con_stat,
			true
		);
	}

	//---------------//
	//DIRECT PHYSICAL//
	//---------------//
	if (_str_effect_type == "DIRECT" && _stct_card._str_card_stat == "PHY"){

		return "PDEF " + scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_pdef_stat,
			true
		);
	}

	//--------------//
	//DIRECT MAGICAL//
	//--------------//
	if (_str_effect_type == "DIRECT" && _stct_card._str_card_stat == "MAG"){

		return "MDEF " + scr_battle_get_stat_preview(
			_stct_target_unit._val_beast_mdef_stat,
			true
		);
	}

	#endregion

	return "";
}