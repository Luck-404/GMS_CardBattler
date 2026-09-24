//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_INSIGHT
// FUNCTION: Resolves Verdant Insight.
//           Increases the target's MAGPOW and MAGDEF by 20 for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_verdant_insight(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//APPLY VERDANT INSIGHT//
	//=======================//
	scr_status_apply_buff("VERDANT_INSIGHT", _ref_target, 20, 3);
}