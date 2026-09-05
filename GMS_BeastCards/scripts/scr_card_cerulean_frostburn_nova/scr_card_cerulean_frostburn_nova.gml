//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROSTBURN_NOVA
// FUNCTION: Resolves the Frostburn Nova card effect.
//           Applies 1 Frostburn to the selected enemy Beast
//           and its adjacent living Beasts.
//           Frozen targets receive 1 additional Frostburn.
//
//===============================================================================//

function scr_card_cerulean_frostburn_nova(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
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

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//-------------------//
	//APPLY FROSTBURN//
	//-------------------//
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

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//CHECK FROZEN//
		//----------------//
		var _flag_frozen =
			scr_check_for_status(
				"FROZEN",
				_ref_affected_target
			) != -1;

		//----------------//
		//SET STATUS TARGET//
		//----------------//
		global.ref_target_beast =
			_ref_affected_target;

		//------------------//
		//BASE FROSTBURN +1//
		//------------------//
		scr_apply_dot_status(
			"FROSTBURN"
		);

		//-------------------------//
		//FROZEN BONUS FROSTBURN//
		//-------------------------//
		if (_flag_frozen){

			scr_apply_dot_status(
				"FROSTBURN"
			);
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast =
			_ref_original_target;
	}
	else{
		global.ref_target_beast =
			_ref_target;
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_battle_sfx_neu_hit,
		0,
		false
	);
}