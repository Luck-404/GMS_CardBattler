//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_POWDER_KEG
// FUNCTION: Resolves Powder Keg.
//           Sets a damage-triggered Trap on the selected enemy Beast.
//
// ARGUMENTS: _stct_card is the Powder Keg Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_powder_keg(_stct_card,_ref_caster,_ref_target){

	//================//
	//SET POWDER KEG//
	//================//
	scr_trap_init("POWDER_KEG",_stct_card,_ref_caster,_ref_target);
}