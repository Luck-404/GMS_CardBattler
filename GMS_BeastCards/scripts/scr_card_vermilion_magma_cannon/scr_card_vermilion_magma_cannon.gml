//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_MAGMA_CANNON
// FUNCTION: Resolves Magma Cannon.
//           Summons a Magma Cannon (3 HP / 3 Magnitude) on the selected ally.
//           The Minion handles its recurring attacks.
//
// ARGUMENTS: _stct_card is the Magma Cannon Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected allied Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_magma_cannon(_stct_card,_ref_caster,_ref_target){

	//===================//
	//SUMMON MAGMA CANNON//
	//===================//
	scr_minion_init("MAGMA_CANNON",_stct_card,_ref_caster,_ref_target);
}