//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKEN_AWAKENS
// FUNCTION: Resolves Kraken Awakens.
//           Deals linear physical damage to the selected target.
//           Applies 2 Bleed and 2 Stormstruck.
//
// ARGUMENTS: _stct_card is the Kraken Awakens card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_kraken_awakens(_stct_card,_ref_caster,_ref_target){

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
	scr_status_apply_dot("BLEED", _ref_target);

	//==================//
	//APPLY STORMSTRUCK//
	//==================//
	scr_status_apply_dot("STORMSTRUCK", _ref_target);
	scr_status_apply_dot("STORMSTRUCK", _ref_target);
}