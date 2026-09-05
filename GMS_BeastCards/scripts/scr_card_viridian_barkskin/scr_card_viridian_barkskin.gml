//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BARKSKIN
// FUNCTION: Resolves the Barkskin card effect.
//           Grants Armor to the caster equal to the card's magnitude.
//
//===============================================================================//

function scr_card_viridian_barkskin(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_armor,0,false);
}