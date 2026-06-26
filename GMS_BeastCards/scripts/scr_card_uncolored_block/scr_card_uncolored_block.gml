//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_BLOCK
// FUNCTION: Resolves the Block card effect.
//           Grants Armor to the caster equal to the card's magnitude.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_block(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GRANT ARMOR//
	//----------------//
	scr_armor_target(_stct_card._val_card_magnitude,_ref_caster);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//----------------//
	//PLAY SOUND//
	//----------------//
}