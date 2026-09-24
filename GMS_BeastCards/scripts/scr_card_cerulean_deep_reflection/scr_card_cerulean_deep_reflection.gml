//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEEP_REFLECTION
// FUNCTION: Resolves Deep Reflection.
//           Draws cards equal to the card magnitude.
//           Requests that the player discard 1 card.
//
// ARGUMENTS: _stct_card is the Deep Reflection card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_deep_reflection(_stct_card,_ref_caster,_ref_target){

	//================//
	//DRAW CARDS//
	//================//
	scr_battle_draw_cards(
		_stct_card._val_card_magnitude
	);

	//================//
	//REQUEST DISCARD//
	//================//
	obj_battle_player_controller.hscr_battle_request_card_discard(1);
}