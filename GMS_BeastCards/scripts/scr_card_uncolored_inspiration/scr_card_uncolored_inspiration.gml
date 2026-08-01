//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_INSPIRATION
// FUNCTION: Resolves the Inspiration card effect.
//           Applies the Inspiration buff.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_inspiration(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY BUFF STATUS//
	//------------------//
	scr_apply_buff_status("INSPIRATION",0,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}