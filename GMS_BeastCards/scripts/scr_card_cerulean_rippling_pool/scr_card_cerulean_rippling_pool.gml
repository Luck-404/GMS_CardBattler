//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RIPPLING_POOL
// FUNCTION: Resolves Rippling Pool.
//           Draws cards equal to the card magnitude.
//           Displays a scrolling card-draw popup.
//
// ARGUMENTS: _stct_card is the Rippling Pool card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_rippling_pool(_stct_card,_ref_caster,_ref_target){

	//================//
	//DRAW CARDS//
	//================//
	scr_battle_draw_cards(
		_stct_card._val_card_magnitude
	);

	//================//
	//SPAWN POPUP//
	//================//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_stct_card._val_card_magnitude) + " CARD DRAW",
		undefined,
		c_blue,
		room_width * 0.5,
		room_height * 0.5
	);
}