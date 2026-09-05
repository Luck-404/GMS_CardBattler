//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_THORN_STORM
// FUNCTION: Resolves the Thorn Storm card effect.
//           Deals two separate magical damage hits to every living Beast
//           on the selected enemy team.
//
//===============================================================================//

function scr_card_viridian_thorn_storm(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//------------------//
	//DAMAGE ENEMY TEAM//
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

		//----------------//
		//HIT TARGET TWICE//
		//----------------//
		repeat (2){

			if (
				!instance_exists(_ref_hit_target) ||
				_ref_hit_target._val_cur_hp <= 0
			){
				break;
			}

			scr_damage_target(
				_stct_card._val_card_magnitude,
				_ref_hit_target
			);

			//----------------//
			//PLAY ANIMATION//
			//----------------//
		}
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_battle_sfx_neu_hit,0,false);
}