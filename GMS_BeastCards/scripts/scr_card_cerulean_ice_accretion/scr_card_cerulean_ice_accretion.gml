//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_ACCRETION
// FUNCTION: Resolves Ice Accretion.
//           Grants the target allied Beast 5 Armor at the end of each round
//           for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_ice_accretion(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//APPLY ARMOR OVER TIME//
	//----------------------//
	scr_apply_buff_status(
		"ARMOR_OVER_TIME",
		_stct_card._val_card_magnitude,
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