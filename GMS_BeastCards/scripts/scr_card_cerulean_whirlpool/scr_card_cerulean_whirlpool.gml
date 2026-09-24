//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WHIRLPOOL
// FUNCTION: Resolves Whirlpool.
//           Banishes the selected target for a number of rounds equal
//           to the card magnitude.
//
// ARGUMENTS: _stct_card is the Whirlpool card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_whirlpool(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY BANISH//
	//================//
	scr_status_apply_cc("BANISH", _ref_target, _stct_card._val_card_magnitude);
}