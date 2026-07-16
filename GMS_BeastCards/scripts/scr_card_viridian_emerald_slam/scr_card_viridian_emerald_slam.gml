//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_EMERALD_SLAM
// FUNCTION: Resolves the Emerald Slam card effect.
//           Applies the Stun crowd-control effect to the target.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_emerald_slam(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//APPLY CC STATUS//
	//----------------//
	scr_apply_cc_status("STUN");

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}