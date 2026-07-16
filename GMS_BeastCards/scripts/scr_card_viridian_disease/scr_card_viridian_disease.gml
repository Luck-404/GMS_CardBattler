//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_DISEASE
// FUNCTION: Resolves the Disease card effect.
//           Applies the Weakness debuff to the target.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_disease(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//APPLY DEBUFF STATUS//
	//--------------------//
	scr_apply_debuff_status("WEAKNESS");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}