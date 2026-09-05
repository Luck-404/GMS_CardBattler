//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_PLATING
// FUNCTION: Resolves the Ice Plating card effect.
//           Grants Armor to the caster.
//
//===============================================================================//

function scr_card_cerulean_ice_plating(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//GAIN ARMOR//
	//-----------//
		scr_armor_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}