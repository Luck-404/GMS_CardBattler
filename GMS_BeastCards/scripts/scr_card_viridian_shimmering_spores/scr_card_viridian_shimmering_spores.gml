//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SHIMMERING_SPORES
// FUNCTION: Resolves Shimmering Spores.
//           Applies Blind to the selected Beast for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_shimmering_spores(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY BLIND//
	//================//
	scr_status_apply_cc("BLIND",3);
}