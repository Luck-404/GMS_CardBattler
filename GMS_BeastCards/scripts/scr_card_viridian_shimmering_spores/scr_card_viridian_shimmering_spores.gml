//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SHIMMERING_SPORES
// FUNCTION: Resolves the Shimmering Spores card effect.
//           Applies Blind to the selected Beast for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_shimmering_spores(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//APPLY BLIND//
	//-----------//
	scr_status_apply_cc("BLIND",3);
}