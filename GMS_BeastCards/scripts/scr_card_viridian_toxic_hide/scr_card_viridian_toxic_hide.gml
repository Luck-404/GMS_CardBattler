//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_HIDE
// FUNCTION: Resolves the Toxic Hide card effect.
//           Grants one stack of Toxic Hide to the caster for 3 rounds.
//           Melee attackers receive 1 Poison per active Toxic Hide stack.
//
//===============================================================================//
function scr_card_viridian_toxic_hide(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY TOXIC HIDE//
	//------------------//
	scr_apply_buff_status("TOXIC_HIDE",1,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}