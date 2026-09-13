//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROST_WEAPON
// FUNCTION: Resolves Frost Weapon.
//           For 2 rounds, the caster's Attacks apply Frostbite.
//
// ARGUMENTS: _stct_card is the Frost Weapon card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_frost_weapon(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE CASTER//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	//================//
	//TARGET CASTER//
	//================//
	var _ref_original_target = global.ref_target_beast;
	global.ref_target_beast = _ref_caster;

	//==================//
	//APPLY FROST WEAPON//
	//==================//
	scr_status_apply_buff(
		"FROST_WEAPON",
		_stct_card._val_card_magnitude,
		2
	);

	//================//
	//RESTORE TARGET//
	//================//
	global.ref_target_beast = _ref_original_target;
}