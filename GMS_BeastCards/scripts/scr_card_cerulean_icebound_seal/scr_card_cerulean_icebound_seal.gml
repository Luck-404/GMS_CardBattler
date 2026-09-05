//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_ICEBOUND_SEAL
// FUNCTION: Resolves Icebound Seal.
//           Transfers the caster's oldest Buff and all of its stacks
//           to the selected target Beast.
//
//===============================================================================//

function scr_card_cerulean_icebound_seal(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//TRANSFER OLDEST BUFF//
	//--------------------//
	scr_transfer_oldest_buff(_ref_caster,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}