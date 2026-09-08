//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WHIRLPOOL
// FUNCTION: Resolves Whirlpool.
//           Banishes the target for 1 round.
//
//===============================================================================//

function scr_card_cerulean_whirlpool(_stct_card,_ref_caster,_ref_target){

	//--------------//
	//APPLY BANISH//
	//--------------//
	scr_status_apply_cc(
		"BANISH",
		_stct_card._val_card_magnitude
	);
}