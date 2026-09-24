//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_MOMENTUM
// FUNCTION: Resolves Deep Momentum.
//           Causes the selected allied Beast's Attacks to generate Mana.
//
// ARGUMENTS: _stct_card is the Deep Momentum card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_deep_momentum(_stct_card,_ref_caster,_ref_target){

	//===================//
	//APPLY DEEP MOMENTUM//
	//===================//
	scr_status_apply_buff("DEEP_MOMENTUM", _ref_target, _stct_card._val_card_magnitude, 2);
}
