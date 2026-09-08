//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_CURSE
// FUNCTION: Resolves Frozen Curse.
//           Applies Frozen Curse for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_frozen_curse(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//APPLY FROZEN CURSE//
	//-------------------//
	scr_status_apply_debuff("FROZEN_CURSE",3);
}