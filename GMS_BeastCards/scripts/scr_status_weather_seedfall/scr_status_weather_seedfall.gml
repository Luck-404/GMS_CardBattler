//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_SEEDFALL
// FUNCTION: Handles the Seedfall global Weather status.
//           Increases Viridian damage by 25% while active.
//           At end of round, summons up to 3 Dormant Seeds into random
//           available Minion slots across the battlefield.
//           Then hatches 1 random Dormant Seed.
//           Owns Seedfall persistent VFX and ambience.
//
//===============================================================================//

function scr_status_weather_seedfall(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			//----------------//
			//DEFAULT LIFETIME//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"WEATHER: SEEDFALL",
					global.list_statuses
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					room_width * 0.5,
					room_height * 0.5,
					"ily_status",
					obj_battle_status
				);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_weather_seedfall;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: SEEDFALL";

			_ref_new_status._str_status_desc =
				"VIRIDIAN DAMAGE +25%. END OF ROUND: SUMMON UP TO 3 DORMANT SEEDS INTO RANDOM OPEN MINION SLOTS, THEN HATCH 1 RANDOM DORMANT SEED.";

			_ref_new_status._spr_status =
				spr_status_weather_seedfall;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._ct_status_stacks =
				1;

			//-------------------//
			//INITIALIZE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//=====================//
			//SEEDFALL START VFX//
			//=====================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_weather_seedfall_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_weather_seedfall_start
			);

			//==========================//
			//PERSISTENT SEEDFALL VFX//
			//==========================//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent_loop(
					spr_battle_vfx_weather_seedfall_persist,
					room_width * 0.5,
					room_height * 0.5,
					1,
					"ily_weather_fx"
				);

			//====================//
			//SEEDFALL AMBIENCE//
			//====================//
			scr_status_start_persistent_audio(
				_ref_new_status,
				bgm_battle_weather_seedfall,
				0.25
			);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(
				global.list_statuses
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//----------------//
			//GET TEAM LISTS//
			//----------------//
			var _arr_team_lists = [
				obj_battle_player_controller._list_beasts_alive,
				obj_battle_enemy_controller._list_beasts_alive
			];

			//====================//
			//BUILD OPEN SLOT LIST//
			//====================//
			var _list_open_slots =
				ds_list_create();

			for (
				var _it_team = 0;
				_it_team < array_length(_arr_team_lists);
				_it_team++
			){

				var _list_beasts =
					_arr_team_lists[_it_team];

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_beasts);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							_list_beasts,
							_it_beast
						);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					if (
						_ref_beast._str_list != "ALIVE" ||
						_ref_beast._val_cur_hp <= 0
					){
						continue;
					}

					//----------------//
					//GET OPEN SLOTS//
					//----------------//
					var _ct_open_slots =
						max(
							0,
							_ref_beast._ct_minions_max -
								ds_list_size(
									_ref_beast._list_minions
								)
						);

					//----------------//
					//REGISTER SLOTS//
					//----------------//
					for (
						var _it_slot = 0;
						_it_slot < _ct_open_slots;
						_it_slot++
					){

						ds_list_add(
							_list_open_slots,
							_ref_beast
						);
					}
				}
			}

			//=======================//
			//SUMMON DORMANT SEEDS//
			//=======================//
			var _ct_seed_spawns =
				min(
					3,
					ds_list_size(_list_open_slots)
				);

			for (
				var _it_seed = 0;
				_it_seed < _ct_seed_spawns;
				_it_seed++
			){

				if (ds_list_size(_list_open_slots) <= 0){
					break;
				}

				//-------------------//
				//ROLL RANDOM SLOT//
				//-------------------//
				var _it_slot =
					irandom(
						ds_list_size(_list_open_slots) - 1
					);

				var _ref_seed_host =
					ds_list_find_value(
						_list_open_slots,
						_it_slot
					);

				//----------------//
				//CONSUME SLOT//
				//----------------//
				ds_list_delete(
					_list_open_slots,
					_it_slot
				);

				if (!instance_exists(_ref_seed_host)){
					continue;
				}

				//-------------------//
				//SUMMON DORMANT SEED//
				//-------------------//
				scr_minion_init("DORMANT_SEED",undefined,undefined,_ref_seed_host);
			}

			//-------------------//
			//DESTROY SLOT LIST//
			//-------------------//
			ds_list_destroy(
				_list_open_slots
			);

			//========================//
			//COLLECT DORMANT SEEDS//
			//========================//
			var _list_dormant_seeds =
				ds_list_create();

			for (
				var _it_team = 0;
				_it_team < array_length(_arr_team_lists);
				_it_team++
			){

				var _list_beasts =
					_arr_team_lists[_it_team];

				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(_list_beasts);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							_list_beasts,
							_it_beast
						);

					if (!instance_exists(_ref_beast)){
						continue;
					}

					for (
						var _it_minion = 0;
						_it_minion < ds_list_size(_ref_beast._list_minions);
						_it_minion++
					){

						var _ref_minion =
							ds_list_find_value(
								_ref_beast._list_minions,
								_it_minion
							);

						if (!instance_exists(_ref_minion)){
							continue;
						}

						if (_ref_minion._str_name != "DORMANT SEED"){
							continue;
						}

						ds_list_add(
							_list_dormant_seeds,
							_ref_minion
						);
					}
				}
			}

			//======================//
			//HATCH ONE RANDOM SEED//
			//======================//
			if (ds_list_size(_list_dormant_seeds) > 0){

				var _it_seed =
					irandom(
						ds_list_size(_list_dormant_seeds) - 1
					);

				var _ref_seed =
					ds_list_find_value(
						_list_dormant_seeds,
						_it_seed
					);

				if (instance_exists(_ref_seed)){
					scr_hatch_dormant_seed(_ref_seed);
				}
			}

			//-------------------//
			//DESTROY SEED LIST//
			//-------------------//
			ds_list_destroy(
				_list_dormant_seeds
			);

			//----------------//
			//TICK LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(
				global.list_statuses
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_status_destroy(
				_ref_status
			);

		break;
	}

	return undefined;
}