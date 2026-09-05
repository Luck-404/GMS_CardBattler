//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_KRAKENSLAM
// FUNCTION: Resolves the Krakenslam card effect.
//           Deals linear physical damage to the selected target.
//           Applies 1 Bleed and 1 Stormstruck if the target survives.
//
//===============================================================================//

function scr_card_cerulean_krakenslam(_stct_card,_ref_caster,_ref_target){

	//------------//
	//DEAL DAMAGE//
	//------------//
	scr_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//----------------//
	//APPLY STATUSES//
	//----------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		//-------------//
		//APPLY BLEED//
		//-------------//
		scr_apply_dot_status(
			"BLEED"
		);

		//-------------------//
		//APPLY STORMSTRUCK//
		//-------------------//
		scr_apply_dot_status(
			"STORMSTRUCK"
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_neu_hit,
		0,
		false
	);
}