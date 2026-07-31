//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_STAMPEDE
// FUNCTION: Resolves the Stampede card effect.
//           Deals percentage-based physical damage to every living Beast
//           on the selected target's team.
//
//===============================================================================//

function scr_card_viridian_stampede(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//------------------//
	//DAMAGE ENTIRE TEAM//
	//------------------//
	for (
		var _it_target = 0;
		_it_target < ds_list_size(_list_targets);
		_it_target++
	){

		var _ref_hit_target = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		scr_damage_target_percent(
			_stct_card._val_card_magnitude,
			_ref_hit_target
		);

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_attack,0,false);
}