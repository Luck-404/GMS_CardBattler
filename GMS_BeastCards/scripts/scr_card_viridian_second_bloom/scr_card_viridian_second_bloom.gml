//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SECOND_BLOOM
// FUNCTION: Resolves the Second Bloom card effect.
//           Grants Second Life to the selected target for four turns.
//
//===============================================================================//

function scr_card_viridian_second_bloom(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY SECOND LIFE//
	//------------------//
	scr_apply_buff_status(
		"SECOND_LIFE",
		0,
		4
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}