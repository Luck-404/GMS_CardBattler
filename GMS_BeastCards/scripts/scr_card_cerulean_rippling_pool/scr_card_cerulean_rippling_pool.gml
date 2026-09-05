//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RIPPLING_POOL
// FUNCTION: Resolves Rippling Pool.
//           Draws 2 cards.
//
//===============================================================================//

function scr_card_cerulean_rippling_pool(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DRAW CARDS//
	//-----------//
	scr_draw_cards(_stct_card._val_card_magnitude);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling(
		"TEXT",
		"+" + string(_stct_card._val_card_magnitude) + " CARD DRAW",
		undefined,
		c_blue,
		room_width * 0.5,
		room_height * 0.5
	);
}