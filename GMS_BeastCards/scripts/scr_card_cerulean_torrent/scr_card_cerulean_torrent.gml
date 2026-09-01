//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TORRENT
// FUNCTION: Resolves the Torrent card effect.
//           Deals linear magical damage to the selected Flank target.
//
//===============================================================================//

function scr_card_cerulean_torrent(_stct_card,_ref_caster,_ref_target){

	//-----------//
	//DEAL DAMAGE//
	//-----------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}