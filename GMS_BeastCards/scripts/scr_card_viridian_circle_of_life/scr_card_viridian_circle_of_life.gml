//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_CIRCLE_OF_LIFE
// FUNCTION: Resolves the Circle of Life Archetype card.
//           Expends every valid corpse on both teams.
//           For each corpse:
//             - Generates 1 Mana.
//             - Heals every living allied Beast for 5 HP.
//             - Summons one Dormant Seed into a random available allied
//               Minion slot.
//             - If no allied Minion slot remains, permanently grows one
//               random existing allied Minion by +1 HP / Max HP / Magnitude.
//
//===============================================================================//

function scr_card_viridian_circle_of_life(_stct_card,_ref_caster,_ref_target){

	if (!instance_exists(_ref_caster)){
		return false;
	}

	//--------------------//
	//GET ALLIED TEAM LIST//
	//--------------------//
	var _list_allies =
		scr_get_target_team_list(
			_ref_caster
		);

	if (_list_allies == undefined){
		return false;
	}

	//----------------//
	//GET GRAVEYARDS//
	//----------------//
	var _list_player_corpses =
		obj_battle_player_controller._list_beasts_graveyard;

	var _list_enemy_corpses =
		obj_battle_enemy_controller._list_beasts_graveyard;

	//----------------//
	//COLLECT CORPSES//
	//----------------//
	var _arr_corpses = [];

	//------------------//
	//PLAYER GRAVEYARD//
	//------------------//
	for (
		var _it_corpse = 0;
		_it_corpse < ds_list_size(_list_player_corpses);
		_it_corpse++
	){

		var _ref_corpse =
			ds_list_find_value(
				_list_player_corpses,
				_it_corpse
			);

		if (!instance_exists(_ref_corpse)){
			continue;
		}

		if (
			_ref_corpse._str_list != "DEAD" ||
			_ref_corpse._val_cur_hp > 0 ||
			_ref_corpse._flag_captured ||
			_ref_corpse._flag_corpse_consumed
		){
			continue;
		}

		array_push(
			_arr_corpses,
			_ref_corpse
		);
	}

	//-----------------//
	//ENEMY GRAVEYARD//
	//-----------------//
	for (
		var _it_corpse = 0;
		_it_corpse < ds_list_size(_list_enemy_corpses);
		_it_corpse++
	){

		var _ref_corpse =
			ds_list_find_value(
				_list_enemy_corpses,
				_it_corpse
			);

		if (!instance_exists(_ref_corpse)){
			continue;
		}

		if (
			_ref_corpse._str_list != "DEAD" ||
			_ref_corpse._val_cur_hp > 0 ||
			_ref_corpse._flag_captured ||
			_ref_corpse._flag_corpse_consumed
		){
			continue;
		}

		array_push(
			_arr_corpses,
			_ref_corpse
		);
	}

	//----------------//
	//NO CORPSES//
	//----------------//
	if (array_length(_arr_corpses) <= 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"NO CORPSES",
			undefined,
			c_white,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return true;
	}

	//-------------------//
	//TRACK TOTAL EXPENDED//
	//-------------------//
	var _ct_corpses_expended =
		0;

	//================//
	//EXPEND CORPSES//
	//================//
	for (
		var _it_corpse = 0;
		_it_corpse < array_length(_arr_corpses);
		_it_corpse++
	){

		var _ref_corpse =
			_arr_corpses[_it_corpse];

		//----------------//
		//EXPEND CORPSE//
		//----------------//
		if (!scr_sacrifice_corpse(_ref_corpse)){
			continue;
		}

		_ct_corpses_expended++;

		//-------------//
		//GENERATE MANA//
		//-------------//
		scr_gain_mana(1);

		//----------------//
		//HEAL ALL ALLIES//
		//----------------//
		for (
			var _it_ally = 0;
			_it_ally < ds_list_size(_list_allies);
			_it_ally++
		){

			var _ref_ally =
				ds_list_find_value(
					_list_allies,
					_it_ally
				);

			if (!instance_exists(_ref_ally)){
				continue;
			}

			if (
				_ref_ally._str_list != "ALIVE" ||
				_ref_ally._val_cur_hp <= 0
			){
				continue;
			}

			scr_heal_target(
				5,
				_ref_ally
			);
		}

		//================================//
		//BUILD AVAILABLE MINION HOST LIST//
		//================================//
		var _arr_open_hosts = [];

		for (
			var _it_ally = 0;
			_it_ally < ds_list_size(_list_allies);
			_it_ally++
		){

			var _ref_ally =
				ds_list_find_value(
					_list_allies,
					_it_ally
				);

			if (!instance_exists(_ref_ally)){
				continue;
			}

			if (
				_ref_ally._str_list != "ALIVE" ||
				_ref_ally._val_cur_hp <= 0
			){
				continue;
			}

			if (
				scr_has_open_minion_slot(
					_ref_ally
				)
			){
				array_push(
					_arr_open_hosts,
					_ref_ally
				);
			}
		}

		//=====================//
		//SUMMON DORMANT SEED//
		//=====================//
		if (array_length(_arr_open_hosts) > 0){

			var _ref_seed_host =
				_arr_open_hosts[
					irandom(
						array_length(_arr_open_hosts) - 1
					)
				];

			scr_init_minion(
				"DORMANT_SEED",
				_stct_card,
				_ref_caster,
				_ref_seed_host
			);
		}

		//=====================================//
		//NO OPEN SLOT — GROW EXISTING MINION//
		//=====================================//
		else{

			var _arr_existing_minions = [];

			//-------------------------//
			//COLLECT ALLIED MINIONS//
			//-------------------------//
			for (
				var _it_ally = 0;
				_it_ally < ds_list_size(_list_allies);
				_it_ally++
			){

				var _ref_ally =
					ds_list_find_value(
						_list_allies,
						_it_ally
					);

				if (!instance_exists(_ref_ally)){
					continue;
				}

				for (
					var _it_minion = 0;
					_it_minion < ds_list_size(_ref_ally._list_minions);
					_it_minion++
				){

					var _ref_minion =
						ds_list_find_value(
							_ref_ally._list_minions,
							_it_minion
						);

					if (!instance_exists(_ref_minion)){
						continue;
					}

					array_push(
						_arr_existing_minions,
						_ref_minion
					);
				}
			}

			//------------------//
			//GROW ONE MINION//
			//------------------//
			if (
				array_length(_arr_existing_minions) > 0
			){

				var _ref_growth_target =
					_arr_existing_minions[
						irandom(
							array_length(_arr_existing_minions) - 1
						)
					];

				scr_grow_minion(
					_ref_growth_target,
					1
				);
			}
		}
	}

	//----------------//
	//MANA FEEDBACK//
	//----------------//
	if (_ct_corpses_expended > 0){

		scr_spawn_popup_scrolling(
			"TEXT",
			"+" +
				string(_ct_corpses_expended) +
				" MANA",
			undefined,
			c_blue,
			_ref_caster.x,
			_ref_caster.y - 72
		);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(
		snd_buff,
		0,
		false
	);

	return true;
}