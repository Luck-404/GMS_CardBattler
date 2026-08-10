//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_SOULCLEANSE
// FUNCTION: Resolves the Soulcleanse card effect.
//           Removes every cleansable Aura hosted by the selected Beast.
//
//===============================================================================//
function scr_card_uncolored_soulcleanse(_stct_card,_ref_caster,_ref_target){

	//---------------//
	//CLEANSE AURAS//
	//---------------//
	scr_cleanse_aura(_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}