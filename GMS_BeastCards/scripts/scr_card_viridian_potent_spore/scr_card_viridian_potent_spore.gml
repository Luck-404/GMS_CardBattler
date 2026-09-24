//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POTENT_SPORE
// FUNCTION: Resolves Potent Spore.
//           Applies 3 Poison stacks to the selected target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_potent_spore(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY 3 POISON//
	//================//
	repeat (3){
		scr_status_apply_dot("POISON", _ref_target);
	}
}