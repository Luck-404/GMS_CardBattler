//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SLEEPING_POLLEN
// FUNCTION: Resolves the Sleeping Pollen card effect.
//           Applies Sleep for 2 rounds to the selected enemy Beast
//           and its adjacent living Beasts.
//
//===============================================================================//
function scr_card_viridian_sleeping_pollen(_stct_card,_ref_caster,_ref_target){

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

	//--------------//
	//APPLY SLEEP//
	//--------------//
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

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//----------------//
		//SWAP TARGET//
		//----------------//
		global.ref_target_beast =
			_ref_affected_target;

		//-------------//
		//APPLY SLEEP//
		//-------------//
		scr_apply_cc_status(
			"SLEEP",
			2
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_debuff,0,false);
}