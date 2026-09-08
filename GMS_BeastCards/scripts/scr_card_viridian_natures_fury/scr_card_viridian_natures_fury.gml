//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_FURY
// FUNCTION: Resolves the Nature's Fury card effect.
//           Deals linear magical damage to the selected target.
//
//===============================================================================//

function scr_card_viridian_natures_fury(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

}
