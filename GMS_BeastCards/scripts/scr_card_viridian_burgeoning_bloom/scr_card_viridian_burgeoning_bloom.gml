//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BURGEONING_BLOOM
// FUNCTION: Resolves the Burgeoning Bloom card effect.
//           Applies an encounter-long Self Aura to the caster.
//           The Aura splashes received healing to adjacent allies
//           while reducing the host's Maximum HP.
//
//===============================================================================//
function scr_card_viridian_burgeoning_bloom(_stct_card,_ref_caster,_ref_target){

	//------------//
	//APPLY AURA//
	//------------//
	scr_apply_aura_status(
		"BURGEONING_BLOOM",
		_stct_card._val_card_magnitude
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}