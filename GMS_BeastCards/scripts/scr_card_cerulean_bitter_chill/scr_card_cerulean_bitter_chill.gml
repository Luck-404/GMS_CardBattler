//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_BITTER_CHILL
// FUNCTION: Resolves the Bitter Chill card effect.
//           Applies 1 Frostbite and Weakness to the selected target.
//
//===============================================================================//

function scr_card_cerulean_bitter_chill(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//----------------//
	//APPLY FROSTBITE//
	//----------------//
	scr_apply_dot_status("FROSTBITE");

	//----------------//
	//APPLY WEAKNESS//
	//----------------//
	scr_apply_debuff_status("WEAKNESS");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}