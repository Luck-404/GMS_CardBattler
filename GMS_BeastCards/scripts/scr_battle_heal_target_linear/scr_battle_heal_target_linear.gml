//===============================================================================//
//
// SCRIPT: SCR_BATTLE_HEAL_TARGET_LINEAR
// FUNCTION: Calculates linearly scaled healing and resolves it on a target
//           battle Beast. Healing attempts still resolve when the target
//           is already at Maximum HP.
//
// INPUTS:   _val_amount - Base healing amount before linear scaling.
//           _ref_target - Battle Beast receiving the healing.
// USES:     Current caster/Card context, linear healing calculation,
//           and standard battle healing resolution.
//
//===============================================================================//

function scr_battle_heal_target_linear(_val_amount,_ref_target){

	#region VALIDATION

	//-----------------//
	//VALIDATE TARGET//
	//-----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//-----------------//
	//VALIDATE AMOUNT//
	//-----------------//
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

	//--------------//
	//VALIDATE CARD//
	//--------------//
	var _ref_cast_card = global.ref_cast_card;

	if (!instance_exists(_ref_cast_card)){
		return false;
	}

	if (!is_struct(_ref_cast_card._ref_card)){
		return false;
	}

	#endregion

	#region HEALING

	//------------------------//
	//CALCULATE LINEAR HEALING//
	//------------------------//
	var _val_healing = scr_battle_get_heal_linear_amount(
		_val_amount,
		_ref_caster,
		_ref_cast_card._ref_card
	);

	if (_val_healing <= 0){
		return false;
	}

	//--------------//
	//RESOLVE HEAL//
	//--------------//
	return scr_battle_heal_target(_val_healing,_ref_target);

	#endregion
}