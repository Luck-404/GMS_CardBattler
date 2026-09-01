//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SNOWDRIFT
// FUNCTION: Resolves Snowdrift.
//           Grants the caster 4 Armor at the end of each round for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_snowdrift(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//TARGET CASTER//
	//----------------//
	var _ref_original_target =
		global.ref_target_beast;

	global.ref_target_beast =
		_ref_caster;

	//----------------------//
	//APPLY ARMOR OVER TIME//
	//----------------------//
	scr_apply_buff_status(
		"ARMOR_OVER_TIME",
		_stct_card._val_card_magnitude,
		3
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