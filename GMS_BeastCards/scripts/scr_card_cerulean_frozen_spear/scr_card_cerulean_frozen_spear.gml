//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROZEN_SPEAR
// FUNCTION: Resolves the Frozen Spear card effect.
//           Deals linear physical damage to the selected Flank target.
//
//===============================================================================//

function scr_card_cerulean_frozen_spear(_stct_card,_ref_caster,_ref_target){

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
	audio_play_sound(
		snd_battle_sfx_neu_hit,
		0,
		false
	);
}