//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_THUNDERSTORM
// FUNCTION: Resolves the Thunderstorm card effect.
//           Begins Storming Weather.
//
//===============================================================================//

function scr_card_cerulean_thunderstorm(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//BEGIN STORMING WEATHER//
	//----------------------//
	scr_apply_weather_status("STORMING");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}