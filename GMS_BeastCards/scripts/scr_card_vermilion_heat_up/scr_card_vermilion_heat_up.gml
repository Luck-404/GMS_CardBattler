//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HEAT_UP
// FUNCTION: Grants the selected Beast 2 Rage.
//
//===============================================================================//

function scr_card_vermilion_heat_up(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN 2 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_target,
		2
	);
}