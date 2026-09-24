//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_BLOCK
// FUNCTION: Resolves Block.
//           Grants Armor to the caster equal to the card's magnitude.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_block(_stct_card,_ref_caster,_ref_target){

	//================//
	//GRANT ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);

}