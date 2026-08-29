//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BRAMBLE_HIDE
// FUNCTION: Resolves the Bramble Hide card effect.
//           Grants the selected Beast Thorns for three turns.
//           Thorns deals stored neutral damage back to melee attackers.
//
//===============================================================================//
function scr_card_viridian_bramble_hide(_stct_card,_ref_caster,_ref_target){

	//--------------//
	//APPLY THORNS//
	//--------------//
	scr_apply_buff_status("THORNS",_stct_card._val_card_magnitude,3);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}