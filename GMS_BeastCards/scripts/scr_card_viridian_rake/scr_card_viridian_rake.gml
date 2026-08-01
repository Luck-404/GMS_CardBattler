//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_RAKE
// FUNCTION: Resolves the Rake card effect.
//           Deals linear physical damage to the selected target.
//           Applies one Bleed stack if the target survives.
//
//===============================================================================//

function scr_card_viridian_rake(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-------------//
	//APPLY BLEED//
	//-------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_apply_dot_status("BLEED");
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}