//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_TOXIC_SNARE
// FUNCTION: Resolves Toxic Snare.
//           Places a DoT-threshold Trap on the selected Beast.
//
//===============================================================================//
function scr_card_viridian_toxic_snare(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_init_trap("TOXIC_SNARE",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}