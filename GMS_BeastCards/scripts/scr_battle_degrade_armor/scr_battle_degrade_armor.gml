//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DEGRADE_ARMOR
// FUNCTION: Reduces a battle Beast's current Armor at the start of its turn.
//           Removes 10% of current Armor, rounded down.
//
// INPUT:    _ref_beast - Battle Beast whose Armor is being degraded.
// USES:     The battle Beast's current Armor value.
//
//===============================================================================//

function scr_battle_degrade_armor(_ref_beast){

	#region VALIDATION

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (_ref_beast._val_armor <= 0){
		return false;
	}

	#endregion

	#region ARMOR DEGRADATION

	//---------------//
	//DEGRADE ARMOR//
	//---------------//
	_ref_beast._val_armor = floor(_ref_beast._val_armor * 0.90);

	#endregion

	return true;
}