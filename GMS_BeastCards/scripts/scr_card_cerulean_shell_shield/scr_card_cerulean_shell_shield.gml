//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHELL_SHIELD
// FUNCTION: Resolves Shell Shield.
//           Grants Armor to the caster.
//
// ARGUMENTS: _stct_card is the Shell Shield card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_shell_shield(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}