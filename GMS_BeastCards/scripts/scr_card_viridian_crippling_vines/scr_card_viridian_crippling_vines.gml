//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CRIPPLING_VINES
// FUNCTION: Resolves the Crippling Vines card effect.
//           Applies Crippling Vines to the selected Beast for three rounds.
//           The Debuff reduces Physical Power and prevents repositioning.
//
//===============================================================================//
function scr_card_viridian_crippling_vines(_stct_card,_ref_caster,_ref_target){

	//-----------------------//
	//APPLY CRIPPLING VINES//
	//-----------------------//
	scr_apply_debuff_status(
		"CRIPPLING_VINES",
		3
	);

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_debuff,
		0,
		false
	);
}