//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CHILLING_WEAKNESS
// FUNCTION: Resolves Chilling Weakness.
//           Applies Weakness for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_chilling_weakness(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY WEAKNESS//
	//----------------//
	scr_status_apply_debuff("WEAKNESS",3);
}