//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_AQUA_STEP
// FUNCTION: Resolves Aqua Step.
//           Swaps the caster's position with the selected allied Beast.
//
//===============================================================================//

function scr_card_cerulean_aqua_step(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//SWAP POSITIONS//
	//----------------//
	scr_reposition_target(_stct_card,_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_beast_summon,0,false);
}