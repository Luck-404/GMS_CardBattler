
//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WHITEOUT
// FUNCTION: Resolves Whiteout.
//           Applies a Debuff that gives the target's card casts a
//           33% chance to whiff for 3 rounds.
//
// ARGUMENTS: _stct_card is the Whiteout Card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_whiteout(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY WHITEOUT//
	//================//
	scr_status_apply_debuff(
		"WHITEOUT",
		_ref_target,
		3,
		_stct_card._val_card_magnitude
	);
}