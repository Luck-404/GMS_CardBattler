//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VERDANT_INSIGHT
// FUNCTION: Resolves the Verdant Insight card effect.
//           Increases the target's MAGPOW and MAGDEF by 20 for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_verdant_insight(_stct_card,_ref_caster,_ref_target){

	//-----------------------//
	//APPLY VERDANT INSIGHT//
	//-----------------------//
	scr_apply_buff_status(
		"VERDANT_INSIGHT",
		20,
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}