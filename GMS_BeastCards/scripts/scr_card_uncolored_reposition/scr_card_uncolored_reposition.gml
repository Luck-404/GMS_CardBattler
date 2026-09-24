//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_REPOSITION
// FUNCTION: Resolves Reposition.
//           Swaps the positions of the caster and target through the shared
//           battle reposition system.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_reposition(_stct_card,_ref_caster,_ref_target){

	//================//
	//SWAP POSITIONS//
	//================//
	scr_battle_reposition_target(
		_ref_caster,
		_ref_target
	);
}