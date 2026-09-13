//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_LIFEBLOOM
// FUNCTION: Resolves Lifebloom.
//           Restores linearly scaled HP to the selected allied Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_lifebloom(_stct_card,_ref_caster,_ref_target){

	//================//
	//HEAL TARGET//
	//================//
	scr_battle_heal_target_linear(_stct_card._val_card_magnitude,_ref_target);
}