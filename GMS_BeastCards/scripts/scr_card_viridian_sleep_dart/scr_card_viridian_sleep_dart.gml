//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SLEEP_DART
// FUNCTION: Resolves the Sleep Dart card effect.
//           Applies Sleep to the selected Beast for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_sleep_dart(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//APPLY SLEEP//
	//-----------//
	scr_apply_cc_status(
		"SLEEP",
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}