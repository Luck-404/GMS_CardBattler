//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PROLIFERATE
// FUNCTION: Resolves the Proliferate Archetype card.
//           Begins with the front enemy Beast.
//           Copies each Beast's current DoTs onto the next Beast while moving
//           toward the back of the formation.
//           Reverses at the back and repeats toward the front.
//           DoTs received earlier during Proliferate are included in later
//           copies, causing the effect to accumulate as it travels.
//
//===============================================================================//

function scr_card_viridian_proliferate(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return;
	}

	//-------------------//
	//GET OPPOSING TEAM//
	//-------------------//
	var _list_enemy;

	if (_ref_caster._str_team == "PLAYER"){

		_list_enemy =
			obj_battle_enemy_controller._list_beasts_alive;
	}
	else{

		_list_enemy =
			obj_battle_player_controller._list_beasts_alive;
	}

	if (_list_enemy == undefined){
		return;
	}

	//----------------//
	//GET TEAM SIZE//
	//----------------//
	var _ct_enemies =
		ds_list_size(
			_list_enemy
		);

	//------------------//
	//NEED 2+ TARGETS//
	//------------------//
	if (_ct_enemies <= 1){

		audio_play_sound(
			snd_debuff,
			0,
			false
		);

		return;
	}


	//=============================//
	//FORWARD: FRONT TOWARD BACK//
	//=============================//
	for (
		var _it_enemy = 0;
		_it_enemy < _ct_enemies - 1;
		_it_enemy++
	){

		var _ref_source =
			ds_list_find_value(
				_list_enemy,
				_it_enemy
			);

		var _ref_destination =
			ds_list_find_value(
				_list_enemy,
				_it_enemy + 1
			);

		if (!instance_exists(_ref_source)){
			continue;
		}

		if (!instance_exists(_ref_destination)){
			continue;
		}

		if (
			_ref_source._val_cur_hp <= 0 ||
			_ref_destination._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//COPY CURRENT DOTS//
		//----------------//
		var _ct_copied =
			scr_copy_dot_statuses(
				_ref_source,
				_ref_destination
			);

		if (_ct_copied > 0){

			scr_spawn_popup_scrolling(
				"TEXT",
				"PROLIFERATE",
				undefined,
				c_green,
				_ref_destination.x,
				_ref_destination.y - 48
			);
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}


	//=============================//
	//REVERSE: BACK TOWARD FRONT//
	//=============================//
	for (
		var _it_enemy = _ct_enemies - 1;
		_it_enemy > 0;
		_it_enemy--
	){

		var _ref_source =
			ds_list_find_value(
				_list_enemy,
				_it_enemy
			);

		var _ref_destination =
			ds_list_find_value(
				_list_enemy,
				_it_enemy - 1
			);

		if (!instance_exists(_ref_source)){
			continue;
		}

		if (!instance_exists(_ref_destination)){
			continue;
		}

		if (
			_ref_source._val_cur_hp <= 0 ||
			_ref_destination._val_cur_hp <= 0
		){
			continue;
		}

		//----------------//
		//COPY CURRENT DOTS//
		//----------------//
		var _ct_copied =
			scr_copy_dot_statuses(
				_ref_source,
				_ref_destination
			);

		if (_ct_copied > 0){

			scr_spawn_popup_scrolling(
				"TEXT",
				"PROLIFERATE",
				undefined,
				c_green,
				_ref_destination.x,
				_ref_destination.y - 48
			);
		}

		//----------------//
		//PLAY ANIMATION//
		//----------------//
	}


	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_debuff,
		0,
		false
	);
}