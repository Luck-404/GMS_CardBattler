//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_FLOW
// FUNCTION: Resolves Tidal Flow.
//           Generates Mana equal to the card magnitude.
//           Draws 1 card and displays both resource-gain popups.
//
// ARGUMENTS: _stct_card is the Tidal Flow card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_tidal_flow(_stct_card,_ref_caster,_ref_target){

	//================//
	//GENERATE MANA//
	//================//
	scr_battle_gain_mana(
		_stct_card._val_card_magnitude
	);

	//================//
	//DRAW CARD//
	//================//
	scr_battle_draw_cards(1);

	//================//
	//SPAWN POPUPS//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_stct_card._val_card_magnitude) + " MANA",
		undefined,
		c_blue,
		(room_width * 0.5) - 300,
		(room_height * 0.5) - 24
	);

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+1 CARD",
		undefined,
		c_black,
		(room_width * 0.5) - 300,
		(room_height * 0.5) + 24
	);
}