//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SAVAGE_MAUL
// FUNCTION: Resolves the Savage Maul card effect.
//           Deals linear physical damage to the selected target.
//
//===============================================================================//

function scr_card_viridian_savage_maul(_stct_card,_ref_caster,_ref_target){

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