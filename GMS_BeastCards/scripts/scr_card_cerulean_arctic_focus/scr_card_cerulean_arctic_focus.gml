//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARCTIC_FOCUS
// FUNCTION: Resolves Arctic Focus.
//           Makes the target allied Beast immune to CC for 2 rounds.
//
//===============================================================================//

function scr_card_cerulean_arctic_focus(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY ARCTIC FOCUS//
	//------------------//
	scr_apply_buff_status("ARCTIC_FOCUS",0,2);

}