//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GLACIAL_CRUSH
// FUNCTION: Deals Linear PHY damage to a single target.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_glacial_crush(_stct_card,_ref_caster,_ref_target){

	//================//
	//DAMAGE TARGET//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);
}