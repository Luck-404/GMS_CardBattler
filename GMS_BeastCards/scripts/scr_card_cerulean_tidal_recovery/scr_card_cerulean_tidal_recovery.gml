//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_RECOVERY
// FUNCTION: Resolves Tidal Recovery.
//           Applies Regeneration for 3 rounds.
//           Heals the target for 10 HP each round.
//
//===============================================================================//

function scr_card_cerulean_tidal_recovery(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//APPLY REGENERATION//
	//--------------------//
	scr_apply_buff_status(
		"REGENERATION",
		_stct_card._val_card_magnitude,
		3
	);

}