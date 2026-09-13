//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENSTEP
// FUNCTION: Resolves Greenstep.
//           Swaps the caster's position with the selected allied Beast.
//           Heals both the caster and target for the card's magnitude.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_greenstep(_stct_card,_ref_caster,_ref_target){

	//================//
	//SWAP POSITIONS//
	//================//
	scr_battle_reposition_target(_stct_card,_ref_caster,_ref_target);

	//================//
	//HEAL BOTH//
	//================//
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_caster);
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_target);
}