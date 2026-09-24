//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HEMOPHILIA
// FUNCTION: Applies Hemophilia to the selected Beast for 3 rounds.
//           Each resolved enemy Attack against the affected Beast applies
//           1 Bleed to that Beast.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_hemophilia(_stct_card,_ref_caster,_ref_target){

	//==================//
	//APPLY HEMOPHILIA//
	//==================//
	scr_status_apply_debuff("HEMOPHILIA", _ref_target, 3, _stct_card._val_card_magnitude);
}