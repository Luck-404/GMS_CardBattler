//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PLAGUE_GARDEN
// FUNCTION: Resolves Plague Garden.
//           Applies its team-bound Buff to the caster's team for 5 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the GLOBAL cast target and is not used for ownership.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_plague_garden(_stct_card,_ref_caster,_ref_target){

	scr_status_apply_buff(
		"PLAGUE_GARDEN",
		_ref_caster,
		0,
		5
	);
}
