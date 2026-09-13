//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_STORM_WISP
// FUNCTION: Resolves Storm Wisp.
//           Summons a Storm Wisp on the selected allied Beast.
//
// ARGUMENTS: _stct_card is the Storm Wisp card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_storm_wisp(_stct_card,_ref_caster,_ref_target){

	//==================//
	//SUMMON STORM WISP//
	//==================//
	scr_minion_init(
		"STORM_WISP",
		_stct_card,
		_ref_caster,
		_ref_target
	);
}