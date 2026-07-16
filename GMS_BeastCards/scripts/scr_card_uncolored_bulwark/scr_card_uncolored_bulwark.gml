//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_BULWARK
// FUNCTION: Resolves the Bulwark card effect.
//           Grants Armor to the caster equal to the card's magnitude.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_bulwark(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(_stct_card._val_card_magnitude,_ref_caster);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_shield,0,false);
}