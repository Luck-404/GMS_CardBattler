//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_MANAVINE
// FUNCTION: Resolves Manavine.
//           Applies the Manavine global mana buff for three rounds.
//           Manavine remains independent from Inspiration so both can stack.
//
//===============================================================================//
function scr_card_viridian_manavine(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY MANA BUFF//
	//------------------//
	scr_apply_buff_status("MANAVINE",1,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}