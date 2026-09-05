//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWFALL
// FUNCTION: Resolves the Snowfall card effect.
//           Begins Snow Weather.
//
//===============================================================================//

function scr_card_cerulean_snowfall(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//BEGIN SNOW WEATHER//
	//------------------//
	scr_apply_weather_status("SNOW");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}