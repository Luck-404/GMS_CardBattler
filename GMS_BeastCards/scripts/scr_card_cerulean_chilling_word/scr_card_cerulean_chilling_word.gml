//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CHILLING_WORD
// FUNCTION: Resolves the Chilling Word card effect.
//           Applies 1 Frostburn to every living Beast on the selected enemy team.
//
//===============================================================================//

function scr_card_cerulean_chilling_word(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//GET TARGET TEAM//
	//----------------//
	var _list_targets =
		scr_get_target_team_list(
			_ref_target
		);

	if (_list_targets == undefined){
		return;
	}

	//----------------//
	//APPLY FROSTBURN//
	//----------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_affected_target =
			ds_list_find_value(
				_list_targets,
				_it_target
			);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		if (_ref_affected_target._val_cur_hp <= 0){
			continue;
		}

		//--------------------------------//
		//TEMPORARILY SET GLOBAL TARGET//
		//--------------------------------//
		var _ref_old_target =
			global.ref_target_beast;

		global.ref_target_beast =
			_ref_affected_target;

		scr_apply_dot_status(
			"FROSTBURN"
		);

		global.ref_target_beast =
			_ref_old_target;
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