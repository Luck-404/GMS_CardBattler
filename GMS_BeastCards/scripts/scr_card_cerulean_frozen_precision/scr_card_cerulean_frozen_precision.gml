//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_PRECISION
// FUNCTION: Resolves Frozen Precision.
//           Causes the caster to ignore Dodge for 2 rounds.
//
// ARGUMENTS: _stct_card is the Frozen Precision card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_frozen_precision(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY FROZEN PRECISION//
	//======================//
	scr_status_apply_buff("FROZEN_PRECISION", _ref_target, 0, 2);
}