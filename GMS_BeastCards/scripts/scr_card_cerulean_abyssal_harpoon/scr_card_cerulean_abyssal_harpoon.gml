//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ABYSSAL_HARPOON
// FUNCTION: Resolves Abyssal Harpoon.
//           Summons an Abyssal Harpoon on the caster.
//
//===============================================================================//

function scr_card_cerulean_abyssal_harpoon(_stct_card,_ref_caster,_ref_target){

	//-----------------------//
	//SUMMON ABYSSAL HARPOON//
	//-----------------------//
	scr_init_minion(
		"ABYSSAL_HARPOON",
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