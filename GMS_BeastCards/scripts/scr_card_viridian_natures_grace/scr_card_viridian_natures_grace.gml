//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_GRACE
// FUNCTION: Resolves Nature's Grace.
//           Grants Armor to the selected target equal to the card's magnitude.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_natures_grace(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(_stct_card._val_card_magnitude,_ref_target);
}