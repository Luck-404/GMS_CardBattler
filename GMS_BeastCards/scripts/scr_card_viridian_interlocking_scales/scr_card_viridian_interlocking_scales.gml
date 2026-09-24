//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_INTERLOCKING_SCALES
// FUNCTION: Resolves Interlocking Scales.
//           Grants linearly scaled Armor to the caster.
//           Armor scales from the caster's PHYPOW.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_interlocking_scales(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(
		"LINEAR",
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}