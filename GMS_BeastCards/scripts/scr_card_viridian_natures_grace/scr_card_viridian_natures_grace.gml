//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURES_GRACE
// FUNCTION: Resolves the Nature's Grace card effect.
//           Grants Armor to the selected target equal to the card's magnitude.
//
//===============================================================================//

function scr_card_viridian_natures_grace(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_shield,0,false);
}