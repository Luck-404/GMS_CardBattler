//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_HEART_OF_THE_FOREST
// FUNCTION: Resolves the Heart of the Forest Archetype card.
//           Applies a teamwide healing-trigger Buff for 5 rounds.
//
//===============================================================================//

function scr_card_viridian_heart_of_the_forest(_stct_card,_ref_caster,_ref_target){

	//--------------------------//
	//APPLY HEART OF THE FOREST//
	//--------------------------//
	scr_apply_buff_status(
		"HEART_OF_THE_FOREST",
		0,
		5
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