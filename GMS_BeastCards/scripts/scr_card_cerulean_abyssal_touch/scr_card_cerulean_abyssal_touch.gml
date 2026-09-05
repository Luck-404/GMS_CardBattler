//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ABYSSAL_TOUCH
// FUNCTION: Resolves the Abyssal Touch card effect.
//           Deals linear magical damage to the selected Ranged target.
//
//===============================================================================//

function scr_card_cerulean_abyssal_touch(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DEAL DAMAGE//
	//-----------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}