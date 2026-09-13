//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_ECHO
// FUNCTION: Resolves Echo.
//           Adds Echo stacks through the shared Echo resource system.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_echo(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ECHO//
	//================//
	scr_status_gain_echo(_stct_card._val_card_magnitude);
}