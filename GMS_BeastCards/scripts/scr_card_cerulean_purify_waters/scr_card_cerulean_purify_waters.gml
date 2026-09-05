//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_PURIFY_WATERS
// FUNCTION: Resolves Purify Waters.
//           Transfers the caster's oldest DoT and all of its stacks
//           to the selected target Beast.
//
//===============================================================================//

function scr_card_cerulean_purify_waters(_stct_card,_ref_caster,_ref_target){

	//-------------------//
	//TRANSFER OLDEST DOT//
	//-------------------//
	scr_transfer_oldest_dot(_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}