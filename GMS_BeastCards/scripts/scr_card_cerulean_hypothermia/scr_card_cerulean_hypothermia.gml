//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_HYPOTHERMIA
// FUNCTION: Resolves Hypothermia.
//           Applies Antiheal for 2 rounds.
//
//===============================================================================//

function scr_card_cerulean_hypothermia(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY ANTIHEAL//
	//----------------//
	scr_status_apply_debuff("ANTIHEAL",2);
}