//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WINTERS_BITE
// FUNCTION: Resolves Winter's Bite.
//           Deals linear physical damage to the selected target.
//           ICEBREAKER consumes Frozen and doubles this card's direct damage.
//
// ARGUMENTS: _stct_card is the Winter's Bite card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_winters_bite(_stct_card,_ref_caster,_ref_target){

	//==================//
	//CHECK ICEBREAKER//
	//==================//
	var _val_icebreaker_multiplier = scr_battle_trigger_icebreaker(_ref_target);

	//================//
	//CALCULATE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude * _val_icebreaker_multiplier;

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_val_damage,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);
}