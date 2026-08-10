//===============================================================================//
//
// SCRIPT: SCR_ARMOR_TARGET_LINEAR
// FUNCTION: Grants linearly scaled Armor to a target battle Beast.
//           PHY cards scale from the caster's PPOW.
//           MAG cards scale from the caster's MPOW.
//           Passes final Armor into scr_armor_target so active Armor-gain
//           modifiers such as Armorbreak are applied consistently.
//
//===============================================================================//
function scr_armor_target_linear(_val_amount,_ref_target){

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
	var _ref_caster =
		global.ref_caster_beast;

	if (!instance_exists(_ref_caster)){
		return false;
	}

	if (_ref_caster._ref_unit == undefined){
		return false;
	}

	//--------------//
	//VALIDATE CARD//
	//--------------//
	var _ref_card =
		global.ref_cast_card;

	if (!instance_exists(_ref_card)){
		return false;
	}

	if (_ref_card._ref_card == undefined){
		return false;
	}

	//----------------//
	//BASE ARMOR VALUE//
	//----------------//
	var _val_armor =
		_val_amount;

	var _str_card_stat =
		_ref_card._ref_card._str_card_stat;

	//----------------//
	//PHYPOW SCALING//
	//----------------//
	if (_str_card_stat == "PHY"){

		var _val_ppow_stat =
			_ref_caster._ref_unit._val_beast_ppow_stat;

		var _val_ppow_mod =
			scr_get_beast_grade_modifier(
				_val_ppow_stat
			);

		_val_armor =
			ceil(
				_val_armor *
				_val_ppow_mod
			);
	}

	//----------------//
	//MAGPOW SCALING//
	//----------------//
	else if (_str_card_stat == "MAG"){

		var _val_mpow_stat =
			_ref_caster._ref_unit._val_beast_mpow_stat;

		var _val_mpow_mod =
			scr_get_beast_grade_modifier(
				_val_mpow_stat
			);

		_val_armor =
			ceil(
				_val_armor *
				_val_mpow_mod
			);
	}

	//-------------//
	//GRANT ARMOR//
	//-------------//
	return scr_armor_target(
		_val_armor,
		_ref_target
	);
}