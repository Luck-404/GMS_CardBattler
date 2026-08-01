//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SPIRIT_FANG
// FUNCTION: Resolves the Spirit Fang card effect.
//           Deals linear magical damage to the selected target.
//           Applies one Venom stack if the target survives.
//
//===============================================================================//

function scr_card_viridian_spirit_fang(_stct_card,_ref_caster,_ref_target){

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