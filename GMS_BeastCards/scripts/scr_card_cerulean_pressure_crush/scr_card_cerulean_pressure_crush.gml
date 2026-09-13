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

	//================//
	//VALIDATE TARGET//
	//================//
	if (!instance_exists(_ref_target)){
		return;
	}

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
	scr_battle_damage_target_armor_pierce(
		_val_damage,
		_ref_target
	);
}