//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PRIMAL_BLAST
// FUNCTION: Resolves the Primal Blast card effect.
//           Deals linear magical damage to the selected target.
//
//===============================================================================//

function scr_card_viridian_primal_blast(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
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