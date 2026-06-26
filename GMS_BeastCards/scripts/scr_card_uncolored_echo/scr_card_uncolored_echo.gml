//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_ECHO
// FUNCTION: Resolves the Echo card effect.
//           Increases the player's Echo counter by the card's magnitude.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_echo(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GAIN ECHO STACKS//
	//----------------//
	global.ct_echo += _stct_card._val_card_magnitude;

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//

	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling("TEXT","+" + string(_stct_card._val_card_magnitude) + " ECHO",undefined,c_white,room_width / 2 - 300,room_height / 2);
}