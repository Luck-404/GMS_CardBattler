//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_PAIN_RESPONSE
// FUNCTION: Applies Pain Response to the caster for 2 rounds.
//           The first HP damage instance each round grants 1 Rage.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_pain_response(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY BUFF//
	//================//
	scr_status_apply_buff("PAIN_RESPONSE", _ref_caster, 1, 2);

}