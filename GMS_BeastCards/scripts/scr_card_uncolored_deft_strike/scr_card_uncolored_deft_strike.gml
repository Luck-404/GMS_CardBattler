//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_DEFT_STRIKE
// FUNCTION: Resolves Deft Strike.
//           Deals damage to the target and applies Bleed.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_uncolored_deft_strike(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//APPLY BLEED//
	//================//
	scr_status_apply_dot("BLEED", _ref_target);
}