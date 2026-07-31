//===============================================================================//
//
// SCRIPT: scr_card_viridian_spinesling
// FUNCTION: Resolves the Wildstrike card effect.
//           Deals physical damage to the target.
//           Plays the associated attack sound.
//
//===============================================================================//

function scr_card_viridian_spinesling(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}