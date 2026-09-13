//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ARCTIC_FOCUS
// FUNCTION: Resolves Arctic Focus.
//           Makes the target allied Beast immune to CC for 2 rounds.
//
// ARGUMENTS: _stct_card is the Arctic Focus card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_arctic_focus(_stct_card,_ref_caster,_ref_target){

	//==================//
	//APPLY ARCTIC FOCUS//
	//==================//
	scr_status_apply_buff(
		"ARCTIC_FOCUS",
		0,
		2
	);
}