//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ABSOLUTE_ZERO
// FUNCTION: Resolves Absolute Zero.
//           Deals linear magical damage to the selected target.
//           ICEBREAKER consumes Frozen and doubles this card's direct damage.
//
// ARGUMENTS: _stct_card is the Absolute Zero card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_absolute_zero(_stct_card,_ref_caster,_ref_target){

	//==================//
	//CHECK ICEBREAKER//
	//==================//
	var _val_icebreaker_multiplier = scr_battle_trigger_icebreaker(_ref_target);

	//================//
	//DEAL DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude * _val_icebreaker_multiplier;

	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);
}