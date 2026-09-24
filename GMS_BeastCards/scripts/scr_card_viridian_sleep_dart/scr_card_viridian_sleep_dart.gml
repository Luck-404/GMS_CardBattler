//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SLEEP_DART
// FUNCTION: Resolves Sleep Dart.
//           Applies Sleep to the selected Beast for 3 rounds.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_viridian_sleep_dart(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY SLEEP//
	//================//
	scr_status_apply_cc("SLEEP", _ref_target, 3);
}