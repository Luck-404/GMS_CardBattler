//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_WILD_VIGOR
// FUNCTION: Resolves the Wild Vigor card effect.
//           Increases the target's PHYPOW and PHYDEF by 20 for 3 rounds.
//
//===============================================================================//
function scr_card_viridian_wild_vigor(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY WILD VIGOR//
	//----------------//
	scr_apply_buff_status(
		"WILD_VIGOR",
		20,
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}