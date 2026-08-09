//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SYMBIOSIS
// FUNCTION: Resolves the Symbiosis card effect.
//           Links the selected target to the caster with Redirect.
//           The target's next incoming damage instance is redirected
//           to the caster.
//
//===============================================================================//

function scr_card_viridian_symbiosis(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY REDIRECT//
	//----------------//
	scr_apply_buff_status("REDIRECT");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}