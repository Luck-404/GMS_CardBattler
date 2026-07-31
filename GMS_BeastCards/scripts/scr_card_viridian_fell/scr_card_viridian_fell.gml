//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_FELL
// FUNCTION: Deals damage based on a percentage of the target's maximum HP.
//           Applies standard physical attack scaling and mitigation.
//           Plays the associated attack sound.
//
//===============================================================================//

function scr_card_viridian_fell(_stct_card,_ref_caster,_ref_target){

	//--------------------------//
	// DEAL MAXIMUM-HP DAMAGE   //
	//--------------------------//
	scr_damage_target_percent(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	// PLAY ANIMATION //
	//----------------//

	//------------//
	// PLAY SOUND //
	//------------//
	audio_play_sound(snd_attack,0,false);
}