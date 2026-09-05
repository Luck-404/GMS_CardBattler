//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_MIRROR
// FUNCTION: Resolves Ice Mirror.
//           For 3 rounds, successful enemy Attack damage against the caster
//           grants the caster 2 Armor.
//
//===============================================================================//

function scr_card_cerulean_ice_mirror(_stct_card,_ref_caster,_ref_target){

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

	//----------------//
	//APPLY ICE MIRROR//
	//----------------//
	scr_apply_buff_status(
		"ICE_MIRROR",
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