//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_BLOWDART
// FUNCTION: Resolves the Blowdart card effect.
//           Deals neutral damage to the selected target.
//           Applies one Poison stack if the target survives.
//
//===============================================================================//

function scr_card_viridian_blowdart(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//--------------//
	//APPLY POISON//
	//--------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_apply_dot_status("POISON");
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	//audio_play_sound(snd_attack,0,false);
}