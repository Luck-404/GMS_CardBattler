//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FELL
// FUNCTION: Resolves Fell.
//           Deals percentage-based physical damage using the target's
//           Maximum HP.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_fell(_stct_card,_ref_caster,_ref_target){

	//==========================//
	//DEAL MAXIMUM-HP DAMAGE//
	//==========================//
	scr_battle_damage_target_percent(
		_stct_card._val_card_magnitude,
		_ref_target
	);
}