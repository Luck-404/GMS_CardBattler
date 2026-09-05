//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RIP_CURRENT
// FUNCTION: Resolves Rip Current.
//           Moves the target Beast backward 1 position.
//           Swaps it with the Beast directly behind it.
//
//===============================================================================//

function scr_card_cerulean_rip_current(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//REPOSITION BACKWARD//
	//--------------------//
	scr_reposition_beast(_ref_target,1);
}