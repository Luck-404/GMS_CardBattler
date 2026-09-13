//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BURGEONING_BLOOM
// FUNCTION: Resolves Burgeoning Bloom.
//           Applies an encounter-long Self Aura to the caster.
//           The Aura splashes received healing to adjacent allies while
//           reducing the host's Maximum HP.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_burgeoning_bloom(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY AURA//
	//================//
	scr_status_apply_aura(
		"BURGEONING_BLOOM",
		_stct_card._val_card_magnitude
	);
}