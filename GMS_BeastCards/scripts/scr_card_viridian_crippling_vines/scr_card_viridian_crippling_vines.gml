//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CRIPPLING_VINES
// FUNCTION: Resolves the Crippling Vines card effect.
//           Applies Crippling Vines to the selected Beast for three rounds.
//           The Debuff reduces Physical Power and prevents repositioning.
//
//===============================================================================//
function scr_card_viridian_crippling_vines(_stct_card,_ref_caster,_ref_target){

	//-----------------------//
	//APPLY CRIPPLING VINES//
	//-----------------------//
	scr_status_apply_debuff(
		"CRIPPLING_VINES",
		3
	);
}