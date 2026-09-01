//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CRASHING_WAVE
// FUNCTION: Resolves the Crashing Wave card effect.
//           Deals linear physical damage to the selected target
//           and its adjacent Beasts.
//
//===============================================================================//

function scr_card_cerulean_crashing_wave(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET LEFT TARGET//
	//----------------//
	var _ref_left_target =
		scr_get_left_target(
			_ref_target
		);

	//-----------------//
	//GET RIGHT TARGET//
	//-----------------//
	var _ref_right_target =
		scr_get_right_target(
			_ref_target
		);

	//----------------//
	//DAMAGE LEFT//
	//----------------//
	if (instance_exists(_ref_left_target)){

		if (_ref_left_target._val_cur_hp > 0){

			scr_damage_target(
				_stct_card._val_card_magnitude,
				_ref_left_target
			);
		}
	}

	//----------------//
	//DAMAGE TARGET//
	//----------------//
	if (instance_exists(_ref_target)){

		if (_ref_target._val_cur_hp > 0){

			scr_damage_target(
				_stct_card._val_card_magnitude,
				_ref_target
			);
		}
	}

	//----------------//
	//DAMAGE RIGHT//
	//----------------//
	if (instance_exists(_ref_right_target)){

		if (_ref_right_target._val_cur_hp > 0){

			scr_damage_target(
				_stct_card._val_card_magnitude,
				_ref_right_target
			);
		}
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_attack,
		0,
		false
	);
}