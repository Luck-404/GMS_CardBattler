//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_GLACIAL_ERUPTION
// FUNCTION: Resolves the Glacial Eruption card effect.
//           Deals linear magical damage to the selected target
//           and its adjacent enemies.
//           Freezes the surviving center target.
//
//===============================================================================//

function scr_card_cerulean_glacial_eruption(_stct_card,_ref_caster,_ref_target){

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

	//------------//
	//DEAL DAMAGE//
	//------------//
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

		scr_damage_target(
			_stct_card._val_card_magnitude,
			_ref_affected_target
		);
	}

	//--------------------//
	//FREEZE CENTER TARGET//
	//--------------------//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		var _ref_original_target =
			global.ref_target_beast;

		global.ref_target_beast =
			_ref_target;

		scr_apply_cc_status(
			"FROZEN"
		);

		global.ref_target_beast =
			_ref_original_target;
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