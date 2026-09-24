//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_BULWARK
// FUNCTION: Resolves Frozen Bulwark.
//           Grants Armor to the selected allied Beast.
//
// ARGUMENTS: _stct_card is the Frozen Bulwark card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_frozen_bulwark(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_target
	);
}