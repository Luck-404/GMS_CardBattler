//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_BULWARK
// FUNCTION: Resolves Frozen Bulwark.
//           Grants 10 Armor to the target allied Beast.
//
//===============================================================================//

function scr_card_cerulean_frozen_bulwark(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//GAIN ARMOR//
	//-----------//
	scr_armor_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_defense,0,false);
}