//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RAZOR_SHELL
// FUNCTION: Resolves Razor Shell.
//           For 3 rounds, successful enemy Attack damage against the caster
//           deals 3 NEU damage to the attacker.
//
//===============================================================================//

function scr_card_cerulean_razor_shell(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//STORE CURRENT TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------//
	//TARGET CASTER//
	//--------------//
	global.ref_target_beast =
		_ref_caster;

	//-----------------//
	//APPLY RAZOR SHELL//
	//-----------------//
	scr_apply_buff_status(
		"RAZOR_SHELL",
		_stct_card._val_card_magnitude,
		3
	);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);
}