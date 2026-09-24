//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FIERY_BLOW
// FUNCTION: Resolves Fiery Blow.
//           Deals linear Physical damage to the target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_fiery_blow(_stct_card,_ref_caster,_ref_target){

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