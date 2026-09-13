//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_CURRENT
// FUNCTION: Resolves Deep Current.
//           Deals linear magical damage to the selected target,
//           then draws 1 card.
//
// ARGUMENTS: _stct_card is the Deep Current card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_deep_current(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//DRAW CARD//
	//================//
	scr_battle_draw_cards(1);
}