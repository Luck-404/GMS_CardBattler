//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_NATURAL_RECOVERY
// FUNCTION: Resolves the Natural Recovery card effect.
//           Grants Armor, prioritizes cleansing CC over DoTs,
//           then restores HP to the selected target.
//
//===============================================================================//

function scr_card_viridian_natural_recovery(_stct_card,_ref_caster,_ref_target){

	//-------------//
	//GRANT ARMOR//
	//-------------//
	scr_armor_target(_stct_card._val_card_magnitude,_ref_target);

	//--------------//
	//CLEANSE STATUS//
	//--------------//
	var _ct_cleansed = scr_cleanse_cc(_ref_target,1);

	if (_ct_cleansed <= 0){
		scr_cleanse_dot(_ref_target,1);
	}

	//-----------//
	//HEAL TARGET//
	//-----------//
	scr_heal_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}