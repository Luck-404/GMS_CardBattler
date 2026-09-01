//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHELL_SHIELD
// FUNCTION: Resolves the Shell Shield card effect.
//           Grants Armor to the caster.
//
//===============================================================================//

function scr_card_cerulean_shell_shield(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//GAIN ARMOR//
	//-----------//
	scr_gain_armor(
		_ref_caster,
		_stct_card._val_card_magnitude
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_defense,
		0,
		false
	);
}