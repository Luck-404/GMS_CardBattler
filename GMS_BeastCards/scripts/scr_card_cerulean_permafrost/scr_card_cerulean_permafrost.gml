//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PERMAFROST
// FUNCTION: Resolves Permafrost.
//           Applies Armorbreak for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_permafrost(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY ARMORBREAK//
	//------------------//
	scr_status_apply_debuff("ARMORBREAK",3);
}