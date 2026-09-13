//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PULLED_UNDER
// FUNCTION: Resolves Pulled Under.
//           Sets a healing-triggered Trap on the selected enemy team.
//
// ARGUMENTS: _stct_card is the Pulled Under card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_pulled_under(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET TRAP//
	//================//
	scr_trap_init(
		"PULLED_UNDER",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}