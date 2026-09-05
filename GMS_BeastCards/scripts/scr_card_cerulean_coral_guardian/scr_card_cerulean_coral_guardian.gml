//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CORAL_GUARDIAN
// FUNCTION: Resolves Coral Guardian.
//           Summons a Coral Guardian on the caster.
//
//===============================================================================//

function scr_card_cerulean_coral_guardian(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//SUMMON CORAL GUARDIAN//
	//----------------------//
	scr_init_minion(
		"CORAL_GUARDIAN",
		_stct_card,
		_ref_caster,
		_ref_caster
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