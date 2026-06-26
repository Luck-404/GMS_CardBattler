//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_DEFT_STRIKE
// FUNCTION: Resolves the Deft Strike card effect.
//           Deals damage to the target and applies Bleed.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_deft_strike(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//--------------//
	//APPLY BLEED//
	//--------------//
	scr_apply_dot_status("BLEED");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
}