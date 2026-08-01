//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_REGENERATE
// FUNCTION: Resolves the Regenerate card effect.
//           Applies Armor Over Time to the selected target.
//           Grants 8 Armor at the end of each turn for 5 rounds.
//
//===============================================================================//

function scr_card_viridian_regenerate(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//APPLY ARMOR OVER TIME//
	//----------------------//
	scr_apply_buff_status(
		"ARMOR_OVER_TIME",
		8,
		5
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	//audio_play_sound(snd_buff,0,false);
}