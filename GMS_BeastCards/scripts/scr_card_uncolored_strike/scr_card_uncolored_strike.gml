//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE
// FUNCTION: Resolves the Strike card effect.
//           Deals damage to the target.
//
//===============================================================================//

function scr_card_uncolored_strike(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);
}