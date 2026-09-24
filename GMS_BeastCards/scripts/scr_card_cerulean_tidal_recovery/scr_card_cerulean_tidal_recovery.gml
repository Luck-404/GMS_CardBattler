//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_RECOVERY
// FUNCTION: Resolves Tidal Recovery.
//           Applies Regeneration for 3 rounds.
//           Heals the selected target each round.
//
// ARGUMENTS: _stct_card is the Tidal Recovery card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_tidal_recovery(_stct_card,_ref_caster,_ref_target){

	//====================//
	//APPLY REGENERATION//
	//====================//
	scr_status_apply_buff("REGENERATION", _ref_target, _stct_card._val_card_magnitude, 3);
}