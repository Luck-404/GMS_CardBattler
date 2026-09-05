//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_UNDERTOW
// FUNCTION: Resolves Undertow.
//           Moves the target Beast forward 1 position.
//           Swaps it with the Beast directly ahead of it.
//
//===============================================================================//

function scr_card_cerulean_undertow(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//REPOSITION FORWARD//
	//-------------------//
	scr_reposition_beast(
		_ref_target,
		-1
	);
}