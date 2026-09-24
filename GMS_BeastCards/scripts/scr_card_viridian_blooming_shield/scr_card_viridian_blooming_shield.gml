//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOOMING_SHIELD
// FUNCTION: Resolves Blooming Shield.
//           Grants Armor to the selected target equal to the card's magnitude.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_blooming_shield(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);

}