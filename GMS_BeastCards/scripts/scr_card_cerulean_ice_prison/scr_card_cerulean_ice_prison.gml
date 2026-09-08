//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_PRISON
// FUNCTION: Resolves Ice Prison.
//           Freezes the target.
//
//===============================================================================//

function scr_card_cerulean_ice_prison(_stct_card,_ref_caster,_ref_target){

	//--------------//
	//APPLY FROZEN//
	//--------------//
	scr_status_apply_cc(
		"FROZEN",
		_stct_card._val_card_magnitude
	);
}