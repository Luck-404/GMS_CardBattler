//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PHEROMONES
// FUNCTION: Resolves Pheromones.
//           Applies Taunt to the caster for two rounds.
//
//===============================================================================//
function scr_card_viridian_pheromones(_stct_card,_ref_caster,_ref_target){

	//-------------//
	// APPLY TAUNT //
	//-------------//
	scr_apply_buff_status("TAUNT",0,2);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}