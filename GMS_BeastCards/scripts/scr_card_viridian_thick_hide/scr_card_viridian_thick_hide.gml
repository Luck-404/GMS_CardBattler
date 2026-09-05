//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THICK_HIDE
// FUNCTION: Resolves the Thick Hide card effect.
//           Grants the caster base Armor plus one additional Armor
//           for each status currently hosted by the caster.
//
//===============================================================================//

function scr_card_viridian_thick_hide(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//CALCULATE ARMOR GAIN//
	//----------------------//
	var _ct_statuses =
		ds_list_size(_ref_caster._list_statuses);

	var _val_armor_gain =
		_stct_card._val_card_magnitude +
		_ct_statuses;

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(
		_val_armor_gain,
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