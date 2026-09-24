//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_RECKLESS_ASSAULT
// FUNCTION: Resolves Reckless Assault.
//           Grants the caster 2 Rage before attacking.
//           Because Rage is gained first, its Linear damage bonus applies
//           to this attack.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_reckless_assault(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//GAIN 2 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_caster,
		2
	);

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
}