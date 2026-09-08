//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENTANGLE
// FUNCTION: Resolves the Entangle card effect.
//           Applies Stun to the selected Beast for one round.
//
//===============================================================================//
function scr_card_viridian_entangle(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY CC STATUS//
	//----------------//
	scr_status_apply_cc("STUN",1);
}