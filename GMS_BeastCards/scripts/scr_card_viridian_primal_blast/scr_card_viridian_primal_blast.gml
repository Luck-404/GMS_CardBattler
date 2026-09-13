//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PRIMAL_BLAST
// FUNCTION: Resolves Primal Blast.
//           Deals linear magical damage to the selected target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_primal_blast(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(_stct_card._val_card_magnitude,_ref_target);
}