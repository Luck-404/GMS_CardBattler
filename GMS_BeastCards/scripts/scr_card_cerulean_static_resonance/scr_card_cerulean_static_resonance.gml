//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_STATIC_RESONANCE
// FUNCTION: Resolves Static Resonance.
//           Applies Static Resonance to the selected Beast for 3 rounds.
//           Whenever that Beast is repositioned, it gains 1 Stormstruck.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_static_resonance(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//APPLY STATIC RESONANCE//
	//=======================//
	scr_status_apply_debuff("STATIC_RESONANCE", _ref_target, 3);
}