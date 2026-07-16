//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_POWER_STRIKE
// FUNCTION: Resolves the Power Strike card effect.
//           Deals damage to the target.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_uncolored_power_strike(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(_stct_card._val_card_magnitude,_ref_target);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}