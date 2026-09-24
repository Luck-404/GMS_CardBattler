//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_MARINE_MEND
// FUNCTION: Resolves Marine Mend.
//           Removes all cleansable Auras from the selected target.
//
// ARGUMENTS: _stct_card is the Marine Mend card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_marine_mend(_stct_card,_ref_caster,_ref_target){

	//================//
	//CLEANSE AURAS//
	//================//
	scr_status_cleanse(
		_ref_target,
		"AURA",
		"ALL"
	);
}