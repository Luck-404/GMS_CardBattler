//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_REJUVENATE
// FUNCTION: Resolves Rejuvenate.
//           Calculates linearly scaled healing from the caster's MAGPOW.
//           Adds that healing as a Regeneration stack for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_rejuvenate(_stct_card,_ref_caster,_ref_target){

	//==================//
	//CALCULATE HEALING//
	//==================//
	var _val_healing = scr_battle_get_heal_linear_amount(_stct_card._val_card_magnitude,_ref_caster,_stct_card);

	//===================//
	//APPLY REGENERATION//
	//===================//
	scr_status_apply_buff("REGENERATION", _ref_target, _val_healing, 3);
}