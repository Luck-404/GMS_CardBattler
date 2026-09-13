//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ANCIENT_CHARTS
// FUNCTION: Resolves Ancient Charts.
//           Requests a Utility-card Tutor selection from the draw pile.
//
// ARGUMENTS: _stct_card is the Ancient Charts card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_ancient_charts(_stct_card,_ref_caster,_ref_target){

	//================//
	//REQUEST TUTOR//
	//================//
	obj_battle_player_controller.hscr_battle_request_utility_tutor(
		_stct_card._val_card_magnitude
	);
}