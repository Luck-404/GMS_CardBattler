//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODSTEP
// FUNCTION: Resolves Bloodstep.
//           Swaps the caster's position with the selected allied Beast.
//
// ARGUMENTS: _stct_card is the Bloodstep Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_bloodstep(_stct_card,_ref_caster,_ref_target){

	//================//
	//SWAP POSITIONS//
	//================//
	scr_battle_reposition_target(
		_ref_caster,
		_ref_target
	);
}