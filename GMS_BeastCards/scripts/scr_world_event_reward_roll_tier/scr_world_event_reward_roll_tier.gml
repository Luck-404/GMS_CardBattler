//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_REWARD_ROLL_TIER
// FUNCTION: Rolls premium quality Tier II / III / IV from supplied weights.
// RETURNS: "II", "III", or "IV". Invalid weights safely default to II.
//
//===============================================================================//

function scr_world_event_reward_roll_tier(_stct_weights){

	if (!is_struct(_stct_weights)){
		return "II";
	}

	var _val_II =
		variable_struct_exists(_stct_weights,"_val_tier_II")
		? max(0,_stct_weights._val_tier_II)
		: 0;

	var _val_III =
		variable_struct_exists(_stct_weights,"_val_tier_III")
		? max(0,_stct_weights._val_tier_III)
		: 0;

	var _val_IV =
		variable_struct_exists(_stct_weights,"_val_tier_IV")
		? max(0,_stct_weights._val_tier_IV)
		: 0;

	var _val_total =
		_val_II +
		_val_III +
		_val_IV;

	if (_val_total <= 0){
		return "II";
	}

	var _val_roll = random(_val_total);

	if (_val_roll < _val_II){
		return "II";
	}

	_val_roll -= _val_II;

	if (_val_roll < _val_III){
		return "III";
	}

	return "IV";
}
