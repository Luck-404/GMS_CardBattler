//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COOLING_MIST
// FUNCTION: Resolves Cooling Mist.
//           Heals the selected target for the card magnitude.
//           Cleanses its oldest DoT.
//
// ARGUMENTS: _stct_card is the Cooling Mist card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_cooling_mist(_stct_card,_ref_caster,_ref_target){

	//================//
	//HEAL TARGET//
	//================//
	scr_battle_heal_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//==================//
	//CLEANSE OLDEST DOT//
	//==================//
	scr_status_cleanse_oldest_dot(_ref_target);
}