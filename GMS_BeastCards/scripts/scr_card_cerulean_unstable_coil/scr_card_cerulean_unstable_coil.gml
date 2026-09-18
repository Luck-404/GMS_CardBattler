//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_UNSTABLE_COIL
// FUNCTION: Resolves Unstable Coil.
//           Applies Unstable Coil to the selected target for 3 rounds.
//
// ARGUMENTS: _stct_card is the Unstable Coil Card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_unstable_coil(_stct_card,_ref_caster,_ref_target){

	//=====================//
	//APPLY UNSTABLE COIL//
	//=====================//
	scr_status_apply_debuff("UNSTABLE_COIL",3);
}