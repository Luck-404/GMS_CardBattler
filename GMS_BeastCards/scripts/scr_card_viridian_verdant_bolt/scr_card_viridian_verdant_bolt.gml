//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_BOLT
// FUNCTION: Resolves Verdant Bolt.
//           Deals magical damage to the selected target.
//           Applies 1 random Bleed, Poison, or Venom stack.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_verdant_bolt(_stct_card,_ref_caster,_ref_target){

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
	//APPLY RANDOM DOT//
	//================//
	var _str_dot = choose("BLEED","POISON","VENOM");
	scr_status_apply_dot(_str_dot, _ref_target);
}