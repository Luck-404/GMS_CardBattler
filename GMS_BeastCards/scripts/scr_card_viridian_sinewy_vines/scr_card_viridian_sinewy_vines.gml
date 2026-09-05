//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SINEWY_VINES
// FUNCTION: Resolves the Sinewy Vines card effect.
//           Grants MAG-scaled linear Armor to the caster.
//
//===============================================================================//

function scr_card_viridian_sinewy_vines(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target_linear(
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