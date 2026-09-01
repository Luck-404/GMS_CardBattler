//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BUBBLE
// FUNCTION: Resolves Bubble.
//           Grants the caster 1 Divine Protection.
//
//===============================================================================//

function scr_card_cerulean_bubble(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//TARGET CASTER//
	//----------------//
	var _ref_original_target =
		global.ref_target_beast;

	global.ref_target_beast =
		_ref_caster;

	//------------------------//
	//GAIN DIVINE PROTECTION//
	//------------------------//
	scr_apply_buff_status(
		"DIVINE_PROTECTION",
		1
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
	audio_play_sound(snd_buff,0,false);
}