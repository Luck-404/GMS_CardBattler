//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENSTEP
// FUNCTION: Resolves Greenstep.
//           Swaps the caster's position with the selected allied Beast.
//           Heals both the caster and target for the card's magnitude.
//
//===============================================================================//

function scr_card_viridian_greenstep(_stct_card,_ref_caster,_ref_target){

	//================//
	//SWAP POSITIONS//
	//================//
	scr_battle_reposition_target(
		_ref_caster,
		_ref_target
	);

	//================//
	//HEAL BOTH//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);

	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);
}