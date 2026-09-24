//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FLAMING_LASHES
// FUNCTION: Grants Flaming Lashes to the selected Beast for 3 rounds.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_flaming_lashes(_stct_card,_ref_caster,_ref_target){

	//======================//
	//APPLY FLAMING LASHES//
	//======================//
	scr_status_apply_buff("FLAMING_LASHES", _ref_target, _stct_card._val_card_magnitude, 3);
}