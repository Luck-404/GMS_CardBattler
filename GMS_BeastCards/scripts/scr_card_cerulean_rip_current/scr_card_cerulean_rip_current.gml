//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RIP_CURRENT
// FUNCTION: Resolves Rip Current.
//           Moves the selected Beast backward 1 position.
//           Swaps it with the Beast directly behind it.
//
// ARGUMENTS: _stct_card is the Rip Current card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_rip_current(_stct_card,_ref_caster,_ref_target){

	//====================//
	//REPOSITION BACKWARD//
	//====================//
	scr_battle_reposition_beast(
		_ref_target,
		1
	);
}