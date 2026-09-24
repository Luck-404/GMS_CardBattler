//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_HIDE
// FUNCTION: Resolves Toxic Hide.
//           Grants 1 stack of Toxic Hide to the caster for 3 rounds.
//           Melee attackers receive 1 Poison per active Toxic Hide stack.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_toxic_hide(_stct_card,_ref_caster,_ref_target){

	//==================//
	//APPLY TOXIC HIDE//
	//==================//
	scr_status_apply_buff("TOXIC_HIDE", _ref_target, 1, 3);
}