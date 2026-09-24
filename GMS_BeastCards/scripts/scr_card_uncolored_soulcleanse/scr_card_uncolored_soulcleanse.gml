//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SOULCLEANSE
// FUNCTION: Resolves Soulcleanse.
//           Removes every cleansable Aura hosted by the selected Beast.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_soulcleanse(_stct_card,_ref_caster,_ref_target){

	//================//
	//CLEANSE AURAS//
	//================//
	scr_status_cleanse(
		_ref_target,
		"AURA",
		"ALL"
	);
}