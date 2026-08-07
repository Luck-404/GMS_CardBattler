//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORN_NET
// FUNCTION: Resolves Thorn Net.
//           Places an Attack-triggered Trap on the selected enemy Beast.
//
//===============================================================================//
function scr_card_viridian_thorn_net(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_init_trap("THORN_NET",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}