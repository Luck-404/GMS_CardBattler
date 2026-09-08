//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORN_NET
// FUNCTION: Resolves Thorn Net.
//           Places an Attack-triggered Trap on the selected Beast.
//
//===============================================================================//
function scr_card_viridian_thorn_net(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_trap_init("THORN_NET",_stct_card,_ref_caster,_ref_target);
}