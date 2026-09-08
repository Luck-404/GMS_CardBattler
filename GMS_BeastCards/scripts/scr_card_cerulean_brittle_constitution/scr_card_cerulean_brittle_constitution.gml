//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BRITTLE_CONSTITUTION
// FUNCTION: Resolves Brittle Constitution.
//           Reduces the target's CON and may preserve its DoT durations.
//
//===============================================================================//

function scr_card_cerulean_brittle_constitution(_stct_card,_ref_caster,_ref_target){

	//----------------------------//
	//APPLY BRITTLE CONSTITUTION//
	//----------------------------//
	scr_status_apply_debuff("BRITTLE_CONSTITUTION",3);
}