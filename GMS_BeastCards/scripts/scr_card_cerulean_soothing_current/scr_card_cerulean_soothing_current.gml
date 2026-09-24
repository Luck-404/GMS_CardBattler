//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SOOTHING_CURRENT
// FUNCTION: Resolves Soothing Current.
//           Heals the caster for the card magnitude.
//
// ARGUMENTS: _stct_card is the Soothing Current card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_soothing_current(_stct_card,_ref_caster,_ref_target){

	//================//
	//HEAL CASTER//
	//================//
	scr_battle_heal_target(
		"FIXED",
		_stct_card._val_card_magnitude,
		_ref_caster
	);
}