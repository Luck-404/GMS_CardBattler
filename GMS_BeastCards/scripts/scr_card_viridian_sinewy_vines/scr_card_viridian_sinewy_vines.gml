//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SINEWY_VINES
// FUNCTION: Resolves Sinewy Vines.
//           Grants MAG-scaled linear Armor to the caster.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_sinewy_vines(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target_linear(_stct_card._val_card_magnitude,_ref_caster);
}