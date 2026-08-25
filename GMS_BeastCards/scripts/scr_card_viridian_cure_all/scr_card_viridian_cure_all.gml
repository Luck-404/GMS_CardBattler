//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CURE_ALL
// FUNCTION: Resolves the Cure All card effect.
//           Removes every cleansable negative status from the selected Beast.
//           Negative statuses include Debuffs, DoTs, and Crowd Control.
//
//===============================================================================//
function scr_card_viridian_cure_all(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return false;
	}

	//-------------------------//
	//CLEANSE NEGATIVE STATUSES//
	//-------------------------//
	scr_cleanse_negative(_ref_target,ds_list_size(_ref_target._list_statuses));

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);

	return true;
}