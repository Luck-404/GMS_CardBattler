//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_DRAGON_MINE
// FUNCTION: Resolves Dragon Mine.
//           Places an Attack-triggered Trap on the selected enemy Beast.
//
// ARGUMENTS: _stct_card is the Dragon Mine Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_dragon_mine(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET TRAP//
	//================//
	scr_trap_init(
		"DRAGON_MINE",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}