//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRYSTAL_SHELL
// FUNCTION: Resolves Crystal Shell.
//           Grants the target allied Beast 2 Divine Protection.
//
//===============================================================================//

function scr_card_cerulean_crystal_shell(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------//
	//STORE TARGET//
	//----------------//
	var _ref_original_target =
		global.ref_target_beast;

	global.ref_target_beast =
		_ref_target;

	//------------------------//
	//GAIN DIVINE PROTECTION//
	//------------------------//
	scr_apply_buff_status(
		"DIVINE_PROTECTION",
		2
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

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