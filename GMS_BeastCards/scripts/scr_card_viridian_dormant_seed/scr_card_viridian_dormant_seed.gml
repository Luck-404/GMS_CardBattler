//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DORMANT_SEED
// FUNCTION: Resolves the Dormant Seed card effect.
//           Summons a Dormant Seed on the selected allied Beast.
//
//===============================================================================//

function scr_card_viridian_dormant_seed(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//SUMMON DORMANT SEED//
	//-------------------//
	scr_init_minion("DORMANT_SEED",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}