//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FRONTLINE_ORDER
// FUNCTION: Grants the selected Beast 1 Rage and 4 Armor.
//
//===============================================================================//

function scr_card_vermilion_frontline_order(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN 1 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_target,
		1
	);

	//================//
	//GAIN 4 ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);

}