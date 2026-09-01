//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WINTER_RESONANCE
// FUNCTION: Resolves the Winter Resonance card effect.
//           SHATTERS the selected target.
//           SHATTER consumes all Frostbite and deals
//           3 NEU damage per Frostbite stack consumed.
//
//===============================================================================//

function scr_card_cerulean_winter_resonance(_stct_card,_ref_caster,_ref_target){

	//---------//
	//SHATTER//
	//---------//
	scr_shatter_target(_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}