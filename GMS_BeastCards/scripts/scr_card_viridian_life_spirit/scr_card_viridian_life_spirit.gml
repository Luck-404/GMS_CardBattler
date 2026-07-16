//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_LIFE_SPIRIT
// FUNCTION: Resolves the Life Spirit card effect.
//           Summons a Life Spirit minion for the target.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_life_spirit(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//SUMMON LIFE SPIRIT//
	//-------------------//
	scr_init_minion("LIFE_SPIRIT",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}