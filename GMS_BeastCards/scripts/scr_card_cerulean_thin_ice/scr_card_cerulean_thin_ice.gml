//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THIN_ICE
// FUNCTION: Resolves Thin Ice.
//           Places an Attack-triggered Trap on the selected enemy Beast.
//
//===============================================================================//

function scr_card_cerulean_thin_ice(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_trap_init("THIN_ICE",_stct_card,_ref_caster,_ref_target);

}