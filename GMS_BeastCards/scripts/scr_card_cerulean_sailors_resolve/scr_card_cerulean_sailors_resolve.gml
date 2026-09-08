//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SAILORS_RESOLVE
// FUNCTION: Resolves Sailor's Resolve.
//           Increases the target allied Beast's healing received
//           by 33% for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_sailors_resolve(_stct_card,_ref_caster,_ref_target){

	//-------------------------//
	//APPLY SAILOR'S RESOLVE//
	//-------------------------//
	scr_apply_buff_status("SAILORS_RESOLVE",_stct_card._val_card_magnitude,3);

}