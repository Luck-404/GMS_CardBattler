//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENTANGLE
// FUNCTION: Resolves Entangle.
//           Applies Stun to the selected Beast for 1 round.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_entangle(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY CC STATUS//
	//================//
	scr_status_apply_cc("STUN", _ref_target, 1);
}