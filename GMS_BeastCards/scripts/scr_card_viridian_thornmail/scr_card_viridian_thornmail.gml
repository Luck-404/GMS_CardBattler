//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORNMAIL
// FUNCTION: Resolves the Thornmail card effect.
//           Grants Armor to the caster and applies Thorns for three turns.
//
//===============================================================================//

function scr_card_viridian_thornmail(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(
		_stct_card._val_card_magnitude,
		_ref_caster
	);

	//--------------//
	//APPLY THORNS//
	//--------------//
	scr_apply_buff_status(
		"THORNS",
		3,
		3
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_armor,0,false);
}