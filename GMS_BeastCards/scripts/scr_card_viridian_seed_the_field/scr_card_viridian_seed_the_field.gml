//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_SEED_THE_FIELD
// FUNCTION: Resolves Seed the Field.
//           Fills every available allied Minion slot with a Dormant Seed.
//           Does not replace existing Minions.
//
//===============================================================================//
function scr_card_viridian_seed_the_field(_stct_card,_ref_caster,_ref_target){

	//--------------------//
	//GET CASTER TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_caster);

	if (_list_targets == undefined){
		return;
	}

	//----------------//
	//TRACK SUMMONS//
	//----------------//
	var _ct_seeds_spawned = 0;

	//--------------------------//
	//FILL AVAILABLE MINION SLOTS//
	//--------------------------//
	for (var _it_target = 0; _it_target < ds_list_size(_list_targets); _it_target++){

		var _ref_affected_target = ds_list_find_value(_list_targets,_it_target);

		if (!instance_exists(_ref_affected_target)){
			continue;
		}

		var _ct_open_slots = max(
			0,
			_ref_affected_target._ct_minions_max -
			ds_list_size(_ref_affected_target._list_minions)
		);

		repeat (_ct_open_slots){

			scr_init_minion(
				"DORMANT_SEED",
				_stct_card,
				_ref_caster,
				_ref_affected_target
			);

			_ct_seeds_spawned++;
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}

	//----------------//
	//FAILED TO SUMMON//
	//----------------//
	if (_ct_seeds_spawned <= 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO OPEN MINION SLOTS",
			undefined,
			c_ltgray,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
}