//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_LANCE
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
	scr_battle_damage_target_armor_pierce(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}