//===============================================================================//
//
// SCRIPT: scr_card_viridian_stalking_swipe
// FUNCTION: Resolves the Deft Strike card effect.
//           Deals damage to the target and applies Bleed.
//           Plays the associated animation and sound effects.
//
//===============================================================================//
function scr_card_viridian_stalking_swipe(_stct_card,_ref_caster,_ref_target){

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