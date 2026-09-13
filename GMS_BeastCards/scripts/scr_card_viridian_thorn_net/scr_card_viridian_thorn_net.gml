//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORN_NET
// FUNCTION: Resolves Thorn Net.
//           Places an Attack-triggered Trap on the selected Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_thorn_net(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET TRAP//
	//================//
	scr_trap_init("THORN_NET",_stct_card,_ref_caster,_ref_target);
}