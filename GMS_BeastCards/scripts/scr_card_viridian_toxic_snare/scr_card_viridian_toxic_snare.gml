//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_SNARE
// FUNCTION: Resolves Toxic Snare.
//           Places a DoT-threshold Trap on the selected Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_toxic_snare(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET TRAP//
	//================//
	scr_trap_init("TOXIC_SNARE",_stct_card,_ref_caster,_ref_target);
}