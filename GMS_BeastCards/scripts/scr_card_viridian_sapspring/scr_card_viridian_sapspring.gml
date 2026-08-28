//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SAPSPRING
// FUNCTION: Resolves the Sapspring card effect.
//           Heals the selected allied Beast and adjacent living allied Beasts.
//           Healing scales linearly from the caster's MAGPOW.
//
//===============================================================================//
function scr_card_viridian_sapspring(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	//-----------------//
	//GET AOE-3 TARGETS//
	//-----------------//
	var _arr_targets = [
		scr_get_left_target(_ref_target),
		_ref_target,
		scr_get_right_target(_ref_target)
	];

	//--------------//
	//HEAL TARGETS//
	//--------------//
	for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

		var _ref_affected_target =
			_arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		scr_heal_target_linear(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_heal,0,false);
}