//===============================================================================//
//
// SCRIPT: SCR_GET_HEAL_LINEAR_AMOUNT
// FUNCTION: Calculates a linearly scaled healing value.
//           PHY healing scales from the caster's PPOW.
//           MAG healing scales from the caster's MPOW.
//           Returns the calculated amount without restoring HP.
//
//===============================================================================//
function scr_get_heal_linear_amount(_val_amount,_ref_caster,_stct_card){

	if (_val_amount <= 0){
		return 0;
	}

	if (!instance_exists(_ref_caster)){
		return 0;
	}

	if (_ref_caster._ref_unit == undefined){
		return 0;
	}

	if (!is_struct(_stct_card)){
		return 0;
	}

	var _val_healing =
		_val_amount;

	//----------------//
	//PHYPOW SCALING//
	//----------------//
	if (_stct_card._str_card_stat == "PHY"){

		var _val_ppow_mod =
			scr_get_beast_grade_modifier(
				_ref_caster._ref_unit._val_beast_ppow_stat
			);

		_val_healing *=
			_val_ppow_mod;
	}

	//----------------//
	//MAGPOW SCALING//
	//----------------//
	else if (_stct_card._str_card_stat == "MAG"){

		var _val_mpow_mod =
			scr_get_beast_grade_modifier(
				_ref_caster._ref_unit._val_beast_mpow_stat
			);

		_val_healing *=
			_val_mpow_mod;
	}

	return max(0,ceil(_val_healing));
}