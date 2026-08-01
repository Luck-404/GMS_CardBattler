//===============================================================================//
//
// SCRIPT: SCR_GET_CARD_TARGET_PREVIEW
// FUNCTION: Returns a target's expected resistance rating for the selected card.
//           Direct PHY attacks inspect PDEF.
//           Direct MAG attacks inspect MDEF.
//           DoTs, debuffs, and crowd control inspect CON.
//
//===============================================================================//

function scr_get_card_target_preview(_stct_card,_ref_target){

	if (_stct_card == undefined){
		return "";
	}

	if (!instance_exists(_ref_target)){
		return "";
	}

	var _str_effect_type = _stct_card._str_card_effect_type;

	//------------------//
	//CONSTITUTION CHECK//
	//------------------//
	if (
		_str_effect_type == "DOT" ||
		_str_effect_type == "DEBUFF" ||
		_str_effect_type == "CC"
	){

		return "CON " + scr_get_battle_stat_preview(
			_ref_target._ref_unit._val_beast_con_stat,
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

		return "PDEF " + scr_get_battle_stat_preview(
			_ref_target._ref_unit._val_beast_pdef_stat,
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

		return "MDEF " + scr_get_battle_stat_preview(
			_ref_target._ref_unit._val_beast_mdef_stat,
			true
		);
	}

	return "";
}