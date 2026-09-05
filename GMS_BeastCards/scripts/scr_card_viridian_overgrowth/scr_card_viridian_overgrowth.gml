//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_OVERGROWTH
// FUNCTION: Resolves the Overgrowth card effect.
//           Grants linearly scaled physical Armor to the caster
//           and the caster's adjacent living allied Beasts.
//
//===============================================================================//

function scr_card_viridian_overgrowth(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET ADJACENT ALLIES//
	//--------------------//
	var _arr_targets = [
		scr_get_left_target(_ref_caster),
		_ref_caster,
		scr_get_right_target(_ref_caster)
	];

	//----------------//
	//GRANT AOE ARMOR//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_affected_target =
			_arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		scr_armor_target_linear(
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
	audio_play_sound(snd_battle_sfx_armor,0,false);
}