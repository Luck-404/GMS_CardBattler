//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_THOUGHTSTEAL
// FUNCTION: Resolves Thoughtsteal.
//           Gains Mana equal to the selected enemy card's Mana Cost.
//           Disables that card for its next attempted cast.
//           Uses the shared Mana Gain system for resource presentation.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target_card is the selected enemy card instance.
// RETURNS: True if Thoughtsteal resolves successfully, otherwise false.
//
//===============================================================================//

function scr_card_uncolored_thoughtsteal(_stct_card,_ref_caster,_ref_target_card){

	//================//
	//STEAL MANA//
	//================//
	var _val_mana_stolen = max(0,_ref_target_card._ref_card._val_card_mana_cost);

	scr_battle_gain_mana(_val_mana_stolen);

	//================//
	//DISABLE CARD//
	//================//
	_ref_target_card._flag_card_disabled = true;

	//================//
	//EXPEND FEEDBACK//
	//================//
	scr_battle_vfx_expend(_ref_target_card);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"CARD DISABLED",
		undefined,
		c_black,
		_ref_target_card.x,
		_ref_target_card.y - 48
	);

	return true;
}