//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODHUNGER
// FUNCTION: Grants Leech to the selected allied Beast.
//           Leech restores 25% of HP damage dealt by its Attacks.
//           Lifetime: 3 rounds.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_bloodhunger(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY LEECH//
	//================//
	scr_status_buff_leech(
		"APPLY",
		undefined,
		0.25,
		3,
		undefined,
		undefined,
		_ref_target
	);
}