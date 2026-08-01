//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIT_VENOM
// FUNCTION: Resolves the Spit Venom card effect.
//           Deals linear physical damage to the selected target.
//           Applies one Venom stack if the target survives.
//
//===============================================================================//

function scr_card_viridian_spit_venom(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//-------------//
	//APPLY VENOM//
	//-------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_apply_dot_status("VENOM");
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}