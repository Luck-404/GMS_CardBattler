//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_MALLEABILITY
// FUNCTION: Resolves the Malleability card effect.
//           Applies Malleability, causing the unit's next spell
//           to ignore all caster requirements.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_malleability(_stct_card,_ref_caster,_ref_target){

	//------------------//
	//APPLY BUFF STATUS//
	//------------------//
	scr_apply_buff_status("MALLEABILITY");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}