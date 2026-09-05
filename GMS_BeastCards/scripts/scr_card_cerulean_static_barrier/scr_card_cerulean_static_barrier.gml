//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_STATIC_BARRIER
// FUNCTION: Resolves Static Barrier.
//           For 3 rounds, successful enemy Attack damage against the caster
//           applies 1 Stormstruck to the attacker.
//
//===============================================================================//

function scr_card_cerulean_static_barrier(_stct_card,_ref_caster,_ref_target){

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

	//--------------------//
	//APPLY STATIC BARRIER//
	//--------------------//
	scr_apply_buff_status(
		"STATIC_BARRIER",
		1,
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
	audio_play_sound(
		snd_buff,
		0,
		false
	);
}