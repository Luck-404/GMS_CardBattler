//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_PRICE
// FUNCTION: Sacrifices 8 caster HP, then deals its linear Physical damage.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected enemy Beast.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_blood_price(_stct_card,_ref_caster,_ref_target){

	//================//
	//SACRIFICE 8 HP//
	//================//
	scr_battle_sacrifice("HOST_HEALTH",_ref_caster,8);

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