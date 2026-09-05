//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ANCIENT_CHARTS
// FUNCTION: Resolves Ancient Charts.
//           Requests one Utility-card Tutor selection from the draw pile.
//
//===============================================================================//

function scr_card_cerulean_ancient_charts(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//REQUEST TUTOR//
	//-------------//
	obj_battle_player_controller.hscr_request_utility_tutor(
		_stct_card._val_card_magnitude
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}