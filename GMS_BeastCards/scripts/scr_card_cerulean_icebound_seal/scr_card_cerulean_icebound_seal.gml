//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICEBOUND_SEAL
// FUNCTION: Resolves Icebound Seal.
//           Transfers the caster's oldest Buff and all of its stacks
//           to the selected target Beast.
//
// ARGUMENTS: _stct_card is the Icebound Seal card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_icebound_seal(_stct_card,_ref_caster,_ref_target){

	//====================//
	//TRANSFER OLDEST BUFF//
	//====================//
	scr_status_transfer_oldest_buff(
		_ref_caster,
		_ref_target
	);
}