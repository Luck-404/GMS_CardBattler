//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_AQUA_STEP
// FUNCTION: Resolves Aqua Step.
//           Swaps the caster's position with the selected allied Beast.
//
// ARGUMENTS: _stct_card is the Aqua Step card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_aqua_step(_stct_card,_ref_caster,_ref_target){

	//================//
	//SWAP POSITIONS//
	//================//
	scr_battle_reposition_target(
		_stct_card,
		_ref_caster,
		_ref_target
	);
}