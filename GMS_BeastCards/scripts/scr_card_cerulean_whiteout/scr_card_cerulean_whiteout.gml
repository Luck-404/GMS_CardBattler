//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WHITEOUT
// FUNCTION: Resolves Whiteout.
//           Reduces the selected target's Accuracy for 3 rounds.
//
// ARGUMENTS: _stct_card is the Whiteout card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_whiteout(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY WHITEOUT//
	//================//
	scr_status_apply_debuff(
		"WHITEOUT",
		3,
		_stct_card._val_card_magnitude
	);
}