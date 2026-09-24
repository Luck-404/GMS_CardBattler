//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPORE_CLOUD
// FUNCTION: Resolves Spore Cloud.
//           Deals percentage-based Max HP damage to the selected target.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_spore_cloud(_stct_card,_ref_caster,_ref_target){

	//======================//
	//DEAL MAX HP DAMAGE//
	//======================//
	scr_battle_damage_target(
		"PERCENT",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);
}