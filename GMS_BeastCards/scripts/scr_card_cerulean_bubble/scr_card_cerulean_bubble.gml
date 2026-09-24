//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BUBBLE
// FUNCTION: Resolves Bubble.
//           Grants the caster 1 Divine Protection.
//
// ARGUMENTS: _stct_card is the Bubble card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_bubble(_stct_card,_ref_caster,_ref_target){


	//========================//
	//GAIN DIVINE PROTECTION//
	//========================//
	scr_status_apply_buff("DIVINE_PROTECTION", _ref_caster, 1);

}