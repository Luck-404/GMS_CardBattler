//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SEED_BARRAGE
// FUNCTION: Resolves the Seed Barrage card effect.
//           Fires four magical attacks at random living Beasts
//           on the selected target's team.
//
//===============================================================================//

function scr_card_viridian_seed_barrage(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	if (ds_list_size(_list_targets) <= 0){
		return;
	}

	//----------------//
	//FIRE FOUR BOLTS//
	//----------------//
	repeat (4){

		var _it_target = irandom(
			ds_list_size(_list_targets) - 1
		);

		var _ref_hit_target = ds_list_find_value(
			_list_targets,
			_it_target
		);

		if (!instance_exists(_ref_hit_target)){
			continue;
		}

		scr_damage_target(
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