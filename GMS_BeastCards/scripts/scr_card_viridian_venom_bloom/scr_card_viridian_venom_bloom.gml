//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VENOM_BLOOM
// FUNCTION: Resolves Venom Bloom.
//           Places a death-triggered Trap on the selected Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_venom_bloom(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET TRAP//
	//================//
	scr_trap_init("VENOM_BLOOM",_stct_card,_ref_caster,_ref_target);
}