//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PHEROMONES
// FUNCTION: Resolves Pheromones.
//           Applies Taunt to the caster for 2 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_pheromones(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY TAUNT//
	//================//
	scr_status_apply_buff("TAUNT", _ref_target, 0, 2);
}