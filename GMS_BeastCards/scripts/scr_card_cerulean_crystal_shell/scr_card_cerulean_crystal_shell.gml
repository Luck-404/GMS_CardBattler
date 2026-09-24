//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRYSTAL_SHELL
// FUNCTION: Resolves Crystal Shell.
//           Grants the selected allied Beast 2 Divine Protection.
//
// ARGUMENTS: _stct_card is the Crystal Shell card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_crystal_shell(_stct_card,_ref_caster,_ref_target){


	//========================//
	//GAIN DIVINE PROTECTION//
	//========================//
	scr_status_apply_buff("DIVINE_PROTECTION", _ref_target, 2);

}