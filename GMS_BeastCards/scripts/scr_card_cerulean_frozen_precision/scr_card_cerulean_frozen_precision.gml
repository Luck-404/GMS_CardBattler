//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_PRECISION
// FUNCTION: Resolves Frozen Precision.
//           Causes the caster to ignore Dodge for 2 rounds.
//
//===============================================================================//

function scr_card_cerulean_frozen_precision(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//APPLY FROZEN PRECISION//
	//----------------------//
	scr_apply_buff_status("FROZEN_PRECISION",0,2);

}