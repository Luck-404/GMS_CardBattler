//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PRIMAL_BLAST
// FUNCTION: Resolves the Primal Blast card effect.
//           Deals linear magical damage to the selected target.
//
//===============================================================================//

function scr_card_viridian_primal_blast(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

}