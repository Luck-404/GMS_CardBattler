//===============================================================================//
//
// SCRIPT: SCR_REWARD_ROLL_CARD_RARITY
// FUNCTION: Rolls I / II / III / IV from a Phase 2 Card rarity-weight struct.
//
// ARGUMENTS: _stct_weights - Struct returned by
//            SCR_REWARD_GET_CARD_RARITY_WEIGHTS.
// RETURNS: Rarity string, defaulting to I when weights are invalid.
//
//===============================================================================//

function scr_reward_roll_card_rarity(_stct_weights){

	#region VALIDATION

	if (!is_struct(_stct_weights)){
		return "I";
	}

	var _val_I = max(0,_stct_weights._val_rarity_I);
	var _val_II = max(0,_stct_weights._val_rarity_II);
	var _val_III = max(0,_stct_weights._val_rarity_III);
	var _val_IV = max(0,_stct_weights._val_rarity_IV);

	var _val_total =
		_val_I +
		_val_II +
		_val_III +
		_val_IV;

	if (_val_total <= 0){
		return "I";
	}

	#endregion

	#region ROLL

	var _val_roll = random(_val_total);

	if (_val_roll < _val_I){
		return "I";
	}

	_val_roll -= _val_I;

	if (_val_roll < _val_II){
		return "II";
	}

	_val_roll -= _val_II;

	if (_val_roll < _val_III){
		return "III";
	}

	return "IV";

	#endregion
}
