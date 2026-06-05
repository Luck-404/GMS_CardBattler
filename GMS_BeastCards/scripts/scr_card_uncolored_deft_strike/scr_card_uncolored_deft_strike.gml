//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_deft_strike(_card,_caster,_target){
	//DEAL 4 damage
	scr_damage_target(4,_target);
	
	//APPLY BLEED
	//scr_apply_dot_effect("BLEED",_target);	
}