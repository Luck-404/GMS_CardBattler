//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ENDLESS_BLOOM
// FUNCTION: Resolves Endless Bloom.
//           Creates a team-bound Buff for the caster's team for 5 rounds.
//
// ARGUMENTS: _stct_card is the Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the GLOBAL cast target and is not used for ownership.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_endless_bloom(_stct_card,_ref_caster,_ref_target){

	scr_status_apply_buff(
		"ENDLESS_BLOOM",
		_ref_caster,
		0,
		5
	);
}
