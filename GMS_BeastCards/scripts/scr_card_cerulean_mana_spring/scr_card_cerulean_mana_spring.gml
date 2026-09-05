//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_MANA_SPRING
// FUNCTION: Resolves Mana Spring.
//           Grants +2 maximum and current Mana for 3 rounds.
//
//===============================================================================//

function scr_card_cerulean_mana_spring(_stct_card,_ref_caster,_ref_target){

	//---------------//
	//APPLY MANA BUFF//
	//---------------//
	scr_apply_buff_status("MANA_SPRING",_stct_card._val_card_magnitude,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}