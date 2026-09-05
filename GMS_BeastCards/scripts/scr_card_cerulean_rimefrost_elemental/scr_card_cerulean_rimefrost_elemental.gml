//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_RIMEFROST_ELEMENTAL
// FUNCTION: Resolves Rimefrost Elemental.
//           Summons a Rimefrost Elemental on the selected allied Beast.
//
//===============================================================================//

function scr_card_cerulean_rimefrost_elemental(_stct_card,_ref_caster,_ref_target){

	//-----------------------------//
	//SUMMON RIMEFROST ELEMENTAL//
	//-----------------------------//
	scr_init_minion("RIMEFROST_ELEMENTAL",_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}