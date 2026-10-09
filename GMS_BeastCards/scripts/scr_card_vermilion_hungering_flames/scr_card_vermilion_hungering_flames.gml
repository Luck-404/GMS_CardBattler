//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_HUNGERING_FLAMES
// FUNCTION: Applies one Hungering Flames Team Aura to the selected team.
//           The Team Status owns all per-Beast Maximum-HP penalties and
//           round-end healing for the Beasts affected by this cast.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_hungering_flames(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	scr_status_apply_aura(
		"HUNGERING_FLAMES",
		_ref_target,
		_stct_card._val_card_magnitude
	);
}
