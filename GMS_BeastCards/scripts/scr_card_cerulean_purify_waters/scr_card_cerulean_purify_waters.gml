//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PURIFY_WATERS
// FUNCTION: Resolves Purify Waters.
//           Transfers the caster's oldest DoT and all of its stacks
//           to the selected target Beast.
//
// ARGUMENTS: _stct_card is the Purify Waters card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_purify_waters(_stct_card,_ref_caster,_ref_target){

	//===================//
	//TRANSFER OLDEST DOT//
	//===================//
	scr_status_transfer_oldest_dot(
		_ref_caster,
		_ref_target
	);
}