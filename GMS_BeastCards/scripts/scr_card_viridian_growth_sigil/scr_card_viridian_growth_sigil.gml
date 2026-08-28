//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GROWTH_SIGIL
// FUNCTION: Resolves the Growth Sigil card effect.
//           Applies the SEEDFALL weather event.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_growth_sigil(_stct_card,_ref_caster,_ref_target){

	//---------------------//
	//APPLY EVENT STATUS//
	//---------------------//
	scr_apply_weather_status("SEEDFALL");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}