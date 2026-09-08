//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICEBOUND_INSTINCT
// FUNCTION: Resolves Icebound Instinct.
//           Increases the caster's card-applied CC duration for 4 rounds.
//
//===============================================================================//

function scr_card_cerulean_icebound_instinct(_stct_card,_ref_caster,_ref_target){

	//------------------------//
	//APPLY ICEBOUND INSTINCT//
	//------------------------//
	scr_apply_buff_status(
		"ICEBOUND_INSTINCT",
		_stct_card._val_card_magnitude,
		4
	);

}