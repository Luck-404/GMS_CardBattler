//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICE_WALL
// FUNCTION: Resolves Ice Wall.
//           Summons an Ice Wall Minion on the caster.
//
//===============================================================================//

function scr_card_cerulean_ice_wall(_stct_card,_ref_caster,_ref_target){

	//-----------------//
	//SUMMON ICE WALL//
	//-----------------//
	scr_init_minion("ICE_WALL",_stct_card,_ref_caster,_ref_caster);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}