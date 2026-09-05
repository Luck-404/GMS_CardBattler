//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SEA_LEGS
// FUNCTION: Resolves the Sea Legs card effect.
//           Grants the caster Immovable for 2 rounds.
//
//===============================================================================//
function scr_card_cerulean_sea_legs(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY IMMOVABLE//
	//----------------//
	scr_apply_buff_status(
		"IMMOVABLE",
		0,
		2
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}