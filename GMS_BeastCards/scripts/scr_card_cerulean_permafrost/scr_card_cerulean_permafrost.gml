//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PERMAFROST
// FUNCTION: Resolves Permafrost.
//           Applies Armorbreak for 3 rounds.
//
// ARGUMENTS: _stct_card is the Permafrost card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_permafrost(_stct_card,_ref_caster,_ref_target){

	//==================//
	//APPLY ARMORBREAK//
	//==================//
	scr_status_apply_debuff(
		"ARMORBREAK",
		3
	);
}