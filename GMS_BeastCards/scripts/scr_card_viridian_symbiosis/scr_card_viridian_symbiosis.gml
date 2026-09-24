//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SYMBIOSIS
// FUNCTION: Resolves Symbiosis.
//           Links the selected target to the caster with Redirect.
//           The target's next incoming damage instance is redirected
//           to the caster.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_symbiosis(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY REDIRECT//
	//================//
	scr_status_apply_buff("REDIRECT", _ref_target);
}