//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILT
// FUNCTION: Resolves the Wilt card effect.
//           Applies Wither to the selected Beast for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_wilt(_stct_card,_ref_caster,_ref_target){

	//--------------//
	//APPLY WITHER//
	//--------------//
	scr_apply_debuff_status(
		"WITHER",
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_debuff,
		0,
		false
	);
}