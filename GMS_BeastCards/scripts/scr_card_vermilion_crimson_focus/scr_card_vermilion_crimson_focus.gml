//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CRIMSON_FOCUS
// FUNCTION: Increases the caster's Critical Hit chance by 15 percentage points
//           for 3 rounds.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_crimson_focus(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY CRIMSON FOCUS//
	//====================//
	scr_status_apply_buff("CRIMSON_FOCUS", _ref_target, 15, 3);
}