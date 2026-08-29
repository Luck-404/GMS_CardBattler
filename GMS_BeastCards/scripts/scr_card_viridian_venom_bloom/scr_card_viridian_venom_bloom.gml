//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VENOM_BLOOM
// FUNCTION: Resolves Venom Bloom.
//           Places a death-triggered Trap on the selected Beast.
//
//===============================================================================//
function scr_card_viridian_venom_bloom(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_init_trap("VENOM_BLOOM",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}