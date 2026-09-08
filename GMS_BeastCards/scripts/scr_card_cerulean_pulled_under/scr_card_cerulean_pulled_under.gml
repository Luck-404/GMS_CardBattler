//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PULLED_UNDER
// FUNCTION: Resolves Pulled Under.
//           Sets a healing-triggered Trap on the selected enemy team.
//
//===============================================================================//

function scr_card_cerulean_pulled_under(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_trap_init("PULLED_UNDER",_stct_card,_ref_caster,_ref_target);

}