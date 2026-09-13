//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_BOND
// FUNCTION: Resolves Nature's Bond.
//           Applies one stack of Nature's Bond for 5 rounds.
//           Heals the caster, triggering the newly applied stack.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_natures_bond(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY NATURE'S BOND//
	//===================//
	scr_status_apply_buff("NATURES_BOND",2,5);

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(_stct_card._val_card_magnitude,_ref_caster);
}