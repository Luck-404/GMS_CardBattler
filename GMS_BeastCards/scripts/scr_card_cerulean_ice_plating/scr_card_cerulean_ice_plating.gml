//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_PLATING
// FUNCTION: Resolves Ice Plating.
//           Grants Armor to the caster.
//
// ARGUMENTS: _stct_card is the Ice Plating card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ice_plating(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN ARMOR//
	//================//
	scr_battle_armor_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}