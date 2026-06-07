//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_deft_strike(_card,_caster,_target){
	//DEAL damage
	scr_damage_target(_card[?"card_magnitude"],_target);
	
	//APPLY BLEED
	scr_apply_dot_status("BLEED");	
	
	//PLAY ANIMATION
	
	//PLAY SOUND

}