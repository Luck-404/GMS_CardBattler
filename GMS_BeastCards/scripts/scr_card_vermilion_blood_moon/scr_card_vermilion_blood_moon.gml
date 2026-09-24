//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_MOON
// FUNCTION: Begins the Blood Moon Event.
//
//===============================================================================//

function scr_card_vermilion_blood_moon(_stct_card,_ref_caster,_ref_target){

	//================//
	//BEGIN BLOOD MOON//
	//================//
	scr_status_apply_event(
		"BLOOD_MOON",
		_stct_card._val_card_magnitude
	);
}