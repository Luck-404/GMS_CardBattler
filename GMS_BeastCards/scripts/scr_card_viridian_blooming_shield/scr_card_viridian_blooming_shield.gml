//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMING_SHIELD
// FUNCTION: Resolves the Blooming Shield card effect.
//           Grants Armor to the selected target equal to the card's magnitude.
//
//===============================================================================//

function scr_card_viridian_blooming_shield(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_battle_armor_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

}