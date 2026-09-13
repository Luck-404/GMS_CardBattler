//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILT
// FUNCTION: Resolves Wilt.
//           Applies Wither to the selected Beast for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_wilt(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY WITHER//
	//================//
	scr_status_apply_debuff("WITHER",3);
}