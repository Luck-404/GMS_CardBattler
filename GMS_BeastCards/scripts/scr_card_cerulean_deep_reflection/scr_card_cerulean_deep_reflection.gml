//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_REFLECTION
// FUNCTION: Resolves Deep Reflection.
//           Draws 2 cards.
//           Requests that the player discard 1 card.
//
//===============================================================================//

function scr_card_cerulean_deep_reflection(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DRAW CARDS//
	//-----------//
	scr_draw_cards(_stct_card._val_card_magnitude);

	//----------------//
	//REQUEST DISCARD//
	//----------------//
	obj_battle_player_controller.hscr_request_card_discard(1);

	//----------------//
	//PLAY ANIMATION//
	//----------------//
}