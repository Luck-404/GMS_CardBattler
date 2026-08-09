//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_EMERALD_SLAM
// FUNCTION: Resolves the Emerald Slam card effect.
//           Applies Stun to the target for one turn.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_emerald_slam(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY CC STATUS//
	//----------------//
	scr_apply_cc_status("STUN",1);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}