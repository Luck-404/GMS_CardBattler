//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_HIDDEN_CARD
// FUNCTION: Resolves Hidden Card.
//           Draws one card for the player and spawns the associated popup.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_uncolored_hidden_card(_stct_card,_ref_caster,_ref_target){

	//================//
	//DRAW CARDS//
	//================//
	scr_battle_draw_cards(1);

	//================//
	//SPAWN POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+1 CARD",
		undefined,
		c_black,
		room_width / 2 - 300,
		room_height / 2
	);
}