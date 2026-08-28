//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_POLLINATE
// FUNCTION: Resolves the Pollinate card effect.
//           Applies Regeneration to the selected allied Beast and the allied
//           Beast immediately behind it for 3 rounds.
//           Each Regeneration stores healing equal to 5% of its host's Max HP.
//
//===============================================================================//
function scr_card_viridian_pollinate(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_target)){
		return;
	}

	//--------------------//
	//GET AFFECTED TARGETS//
	//--------------------//
	var _arr_targets = [
		_ref_target,
		scr_get_right_target(_ref_target)
	];

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------------//
	//APPLY REGENERATION//
	//--------------------//
	for (var _it_target = 0; _it_target < array_length(_arr_targets); _it_target++){

		var _ref_affected_target =
			_arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//------------------//
		//CALCULATE HEALING//
		//------------------//
		var _val_healing = max(
			1,
			ceil(
				_ref_affected_target._val_max_hp *
				_stct_card._val_card_magnitude
			)
		);

		//-------------------//
		//APPLY REGENERATION//
		//-------------------//
		global.ref_target_beast =
			_ref_affected_target;

		scr_apply_buff_status(
			"REGENERATION",
			_val_healing,
			3
		);

		//----------------//
		//IMMEDIATE HEAL//
		//----------------//
		scr_heal_target(
			_val_healing,
			_ref_affected_target
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
	audio_play_sound(snd_heal,0,false);
}