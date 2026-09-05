//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_ECHO
// FUNCTION: Resolves the Echo card effect.
//           Adds Echo stacks through the shared Echo resource system.
//
//===============================================================================//

function scr_card_uncolored_echo(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//GAIN ECHO//
	//-----------//
	scr_gain_echo(
		_stct_card._val_card_magnitude
	);
}