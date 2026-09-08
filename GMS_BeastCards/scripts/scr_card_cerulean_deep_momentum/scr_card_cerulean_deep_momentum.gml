//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_MOMENTUM
// FUNCTION: Resolves Deep Momentum.
//           Causes the target allied Beast's Attacks to generate Mana.
//
//===============================================================================//

function scr_card_cerulean_deep_momentum(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//APPLY DEEP MOMENTUM//
	//-------------------//
	scr_apply_buff_status(
		"DEEP_MOMENTUM",
		_stct_card._val_card_magnitude,
		2
	);

}