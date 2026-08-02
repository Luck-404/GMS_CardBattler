//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_ROOTED_DEFENSE
// FUNCTION: Resolves the Rooted Defense card effect.
//           Grants Armor to the caster equal to the card's magnitude.
//
//===============================================================================//

function scr_card_viridian_rooted_defense(_stct_card,_ref_caster,_ref_target){

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
	audio_play_sound(snd_shield,0,false);
}