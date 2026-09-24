//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ROOTED_DEFENSE
// FUNCTION: Resolves Rooted Defense.
//           Grants Armor to the caster equal to the card's magnitude.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_rooted_defense(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}