//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CRIPPLING_VINES
// FUNCTION: Resolves Crippling Vines.
//           Applies Crippling Vines to the selected Beast for 3 rounds.
//           Reduces PHYPOW by the Card's Magnitude and prevents repositioning.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_crippling_vines(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//APPLY CRIPPLING VINES//
	//=======================//
	scr_status_apply_debuff(
		"CRIPPLING_VINES",
		_ref_target,
		3,
		_stct_card._val_card_magnitude
	);
}