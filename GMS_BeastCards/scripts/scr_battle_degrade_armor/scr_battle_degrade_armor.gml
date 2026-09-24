//===============================================================================//
//
// SCRIPT: SCR_BATTLE_DEGRADE_ARMOR
// FUNCTION: Degrades current Armor at its existing turn phase.
//           Preserves floor(current Armor * 0.90) and original boolean result.
//
// ARGUMENTS: _ref_beast - battle Beast whose Armor degrades.
// RETURNS: True if Armor was positive on entry, otherwise false.
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
	var _val_armor_before = _ref_beast._val_armor;
	var _val_armor_after = floor(_val_armor_before * 0.90);
	scr_battle_destroy_armor(_ref_beast,_val_armor_before - _val_armor_after);

	#endregion

	return true;
}