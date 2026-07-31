//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_VIRIDIAN_BURST
// FUNCTION: Resolves the Viridian Burst card effect.
//           Damages the selected target and its immediate adjacent allies.
//           Applies one Poison stack to each affected living target.
//
//===============================================================================//

function scr_card_viridian_viridian_burst(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//--------------------//
	//GET AFFECTED TARGETS//
	//--------------------//
	var _arr_targets = [
		scr_get_left_target(_ref_target),
		_ref_target,
		scr_get_right_target(_ref_target)
	];

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target = global.ref_target_beast;

	//----------------------//
	//HIT AFFECTED TARGETS//
	//----------------------//
	for (
		var _it_target = 0;
		_it_target < array_length(_arr_targets);
		_it_target++
	){

		var _ref_affected_target = _arr_targets[_it_target];

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (
			_ref_affected_target._str_list != "ALIVE" ||
			_ref_affected_target._val_cur_hp <= 0
		){
			continue;
		}

		/*
			The current status system reads
			global.ref_target_beast internally.
		*/
		global.ref_target_beast = _ref_affected_target;

		//------------//
		//DEAL DAMAGE//
		//------------//
		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);

		//--------------//
		//APPLY POISON//
		//--------------//
		if (_ref_affected_target._val_cur_hp > 0){
			scr_apply_dot_status("POISON");
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//----------------------//
	//RESTORE MAIN TARGET//
	//----------------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast = _ref_original_target;
	}
	else{
		global.ref_target_beast = _ref_target;
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}