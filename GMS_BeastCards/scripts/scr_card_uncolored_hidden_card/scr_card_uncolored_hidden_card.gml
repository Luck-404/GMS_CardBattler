//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_HIDDEN_CARD
// FUNCTION: Resolves the Hidden Card card effect.
//           Draws one card for the player.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_hidden_card(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DRAW CARDS//
	//-----------//
	scr_draw_cards(1);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling("TEXT","+1 CARD",undefined,c_black,room_width / 2 - 300,room_height / 2);
}