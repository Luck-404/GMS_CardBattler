//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_DANCING_FLAME
// FUNCTION: Applies Confused to the selected Beast for 1 round.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_dancing_flame(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY CONFUSED//
	//================//
	scr_status_apply_cc("CONFUSED", _ref_target, _stct_card._val_card_magnitude);
}