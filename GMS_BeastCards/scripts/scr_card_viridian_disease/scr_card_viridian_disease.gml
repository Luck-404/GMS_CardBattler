//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DISEASE
// FUNCTION: Resolves Disease.
//           Applies Weakness to the target for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_disease(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY DEBUFF STATUS//
	//====================//
	scr_status_apply_debuff("WEAKNESS", _ref_target, 3);
}