//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DISTRACTING_TRAP
// FUNCTION: Resolves Distracting Trap.
//           Places a hidden Trap on the selected allied Beast.
//
//===============================================================================//

function scr_card_viridian_distracting_trap(_stct_card,_ref_caster,_ref_target){

	//----------//
	//SET TRAP//
	//----------//
	scr_init_trap(
		"DISTRACTING_TRAP",
		_stct_card,
		_ref_caster,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);
}