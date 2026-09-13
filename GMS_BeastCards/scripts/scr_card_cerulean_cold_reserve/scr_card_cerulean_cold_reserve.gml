//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COLD_RESERVE
// FUNCTION: Resolves Cold Reserve.
//           Consumes Armor from the caster up to the card magnitude.
//           Heals the caster for 1 HP per Armor consumed.
//
// ARGUMENTS: _stct_card is the Cold Reserve card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_cold_reserve(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//=====================//
	//CALCULATE CONSUMPTION//
	//=====================//
	var _val_armor_consumed = min(max(0,_ref_caster._val_armor),_stct_card._val_card_magnitude);

	if (_val_armor_consumed <= 0){
		return;
	}

	//================//
	//CONSUME ARMOR//
	//================//
	_ref_caster._val_armor = max(0,_ref_caster._val_armor - _val_armor_consumed);

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		_val_armor_consumed,
		_ref_caster
	);
}