//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAIN
// FUNCTION: Resolves the Rain card effect.
//           Begins Rain Weather.
//
//===============================================================================//
function scr_card_cerulean_rain(_stct_card,_ref_caster,_ref_target){

	//------------//
	//BEGIN RAIN//
	//------------//
	scr_apply_weather_status(
		"RAIN",
		5
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}