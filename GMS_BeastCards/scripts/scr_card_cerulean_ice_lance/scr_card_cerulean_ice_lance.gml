//===============================================================================//
//
// SCRIPT: 
// FUNCTION: Resolves Ice Lance.
//           Deals armor-piercing magical damage to the selected target.
//
// ARGUMENTS: _stct_card is the Ice Lance card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ice_lance(_stct_card,_ref_caster,_ref_target){

	//====================//
	//DEAL PIERCING DAMAGE//
	//====================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, pierce_armor: true, card_instance: global.ref_cast_card}
	);
}