//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ROUGH_SEAS
// FUNCTION: Resolves Rough Seas.
//           Applies an encounter-long Team Aura to the caster.
//
// ARGUMENTS: _stct_card is the Rough Seas card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_rough_seas(_stct_card,_ref_caster,_ref_target){

	//================//
	//APPLY ROUGH SEAS//
	//================//
	scr_status_apply_aura(
		"ROUGH_SEAS",
		0
	);
}