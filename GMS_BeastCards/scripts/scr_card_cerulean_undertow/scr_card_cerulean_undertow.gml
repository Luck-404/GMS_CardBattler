//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_UNDERTOW
// FUNCTION: Resolves Undertow.
//           Moves the selected Beast forward 1 position.
//           Swaps it with the Beast directly ahead of it.
//
// ARGUMENTS: _stct_card is the Undertow card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_undertow(_stct_card,_ref_caster,_ref_target){

	//===================//
	//REPOSITION FORWARD//
	//===================//
	scr_battle_reposition_beast(
		_ref_target,
		-1
	);
}