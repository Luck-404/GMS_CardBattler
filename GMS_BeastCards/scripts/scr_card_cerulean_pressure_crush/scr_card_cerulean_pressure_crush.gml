//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PRESSURE_CRUSH
// FUNCTION: Resolves Pressure Crush.
//           Deals armor-piercing physical damage equal to a percentage
//           of the target's current Armor.
//
// ARGUMENTS: _stct_card is the Pressure Crush card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_pressure_crush(_stct_card,_ref_caster,_ref_target){

	//=======================//
	//CALCULATE ARMOR DAMAGE//
	//=======================//
	var _val_damage = _ref_target._val_armor * (_stct_card._val_card_magnitude / 100);

	if (_val_damage <= 0){
		return;
	}

	//======================//
	//DEAL PIERCING DAMAGE//
	//======================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_val_damage,
		{card: _stct_card, pierce_armor: true, card_instance: global.ref_cast_card}
	);
}