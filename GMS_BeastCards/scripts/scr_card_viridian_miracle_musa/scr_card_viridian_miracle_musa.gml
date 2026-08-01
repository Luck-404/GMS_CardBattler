//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_MIRACLE_MUSA
// FUNCTION: Resolves the Miracle Musa card effect.
//           Applies the Overhealth buff to the target.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_miracle_musa(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY BUFF STATUS//
	//------------------//
	scr_apply_buff_status("OVERHEALTH",0,4);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}