//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DISEASE
// FUNCTION: Resolves the Disease card effect.
//           Applies Weakness to the target for three rounds.
//
//===============================================================================//
function scr_card_viridian_disease(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//APPLY DEBUFF STATUS//
	//--------------------//
	scr_status_apply_debuff("WEAKNESS",3);
}