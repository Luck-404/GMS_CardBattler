//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SHIV
// FUNCTION: Resolves Shiv.
//           Deals Armor-piercing damage to the target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_shiv(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, pierce_armor: true, card_instance: global.ref_cast_card}
	);
}
