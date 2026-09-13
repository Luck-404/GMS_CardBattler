//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DORMANT_SEED
// FUNCTION: Resolves Dormant Seed.
//           Summons a Dormant Seed on the selected allied Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_dormant_seed(_stct_card,_ref_caster,_ref_target){

	//===================//
	//SUMMON DORMANT SEED//
	//===================//
	scr_minion_init("DORMANT_SEED",_stct_card,_ref_caster,_ref_target);
}