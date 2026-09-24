//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_STORMING
// FUNCTION: Handles the Storming global Weather Status.
//           At end of round, randomly swaps one adjacent movable Beast pair.
//           After a short presentation delay, strikes 2 different random living
//           Beasts for 2 fixed NEU damage and applies 1 Stormstruck to each
//           survivor.
//           Storming effects resolve independently of Card or caster context.
//           Owns Storming start VFX, persistent VFX, and Weather ambience.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Status, and _val_lifetime optionally sets its duration.
// RETURNS: The active Storming Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_weather_storming(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//----------------------//
			//VALIDATE GLOBAL LIST//
			//----------------------//
			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"WEATHER: STORMING",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//=====================//
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status =
				scr_status_weather_storming;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: STORMING";

			_ref_new_status._str_status_desc =
				"Weather. At the end of each round, randomly move 1 Beast forward or backward by 1 position. Strike 2 random Beasts for 2 NEU dmg and apply 1 Stormstruck to each.";

			_ref_new_status._spr_status =
				spr_status_weather_storming;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region =
				"END";

			//=====================//
			//REPEAT PRESENTATION//
			//=====================//
			_ref_new_status._str_storming_phase =
				"READY";

			_ref_new_status._ct_storming_delay =
				0;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//====================//
			//STORMING START VFX//
			//====================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_weather_storming_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_weather_storming_start
			);

			//=========================//
			//PERSISTENT STORMING VFX//
			//=========================//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent_loop(
					spr_battle_vfx_weather_storming_persist,
					room_width * 0.5,
					room_height * 0.5,
					1,
					"ily_weather_fx"
				);

			//===================//
			//STORMING AMBIENCE//
			//===================//
			scr_status_start_persistent_audio(
				_ref_new_status,
					bgm_battle_weather_storming,
				0.25
			);

			//==================//
			//REPOSITION STATUS//
			//==================//
			scr_status_reposition(
				global.list_statuses
			);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//==========================//
			//WAIT FOR LIGHTNING PHASE//
			//==========================//
			if (_ref_status._str_storming_phase == "WAIT_LIGHTNING"){

				if (_ref_status._ct_storming_delay > 0){

					_ref_status._ct_storming_delay--;

					return undefined;
				}

				_ref_status._str_storming_phase =
					"LIGHTNING";
			}

			#region REPOSITION PHASE

			//==================//
			//REPOSITION PHASE//
			//==================//
			if (_ref_status._str_storming_phase == "READY"){

				var _arr_moves = [];
				var _arr_team_lists = [];

				//================//
				//GET TEAM LISTS//
				//================//
				if (instance_exists(obj_battle_player_controller)){

					var _list_player_beasts =
						obj_battle_player_controller._list_beasts_alive;

					if (ds_exists(_list_player_beasts,ds_type_list)){
						array_push(
							_arr_team_lists,
							_list_player_beasts
						);
					}
				}

				if (instance_exists(obj_battle_enemy_controller)){

					var _list_enemy_beasts =
						obj_battle_enemy_controller._list_beasts_alive;

					if (ds_exists(_list_enemy_beasts,ds_type_list)){
						array_push(
							_arr_team_lists,
							_list_enemy_beasts
						);
					}
				}

				//===========================//
				//FIND ADJACENT MOVE PAIRS//
				//===========================//
				for (
					var _it_team = 0;
					_it_team < array_length(_arr_team_lists);
					_it_team++
				){

					var _list_team =
						_arr_team_lists[_it_team];

					for (
						var _it_beast = 0;
						_it_beast < ds_list_size(_list_team) - 1;
						_it_beast++
					){

						var _ref_beast = ds_list_find_value(
							_list_team,
							_it_beast
						);

						var _ref_adjacent = ds_list_find_value(
							_list_team,
							_it_beast + 1
						);

						if (
							!instance_exists(_ref_beast) ||
							!instance_exists(_ref_adjacent)
						){
							continue;
						}

						if (
							_ref_beast._str_list != "ALIVE" ||
							_ref_beast._val_cur_hp <= 0 ||
							_ref_adjacent._str_list != "ALIVE" ||
							_ref_adjacent._val_cur_hp <= 0
						){
							continue;
						}

						//=====================//
						//CHECK MOVEMENT LOCKS//
						//=====================//
						if (
							!scr_battle_can_reposition(_ref_beast) ||
							!scr_battle_can_reposition(_ref_adjacent)
						){
							continue;
						}

						array_push(
							_arr_moves,
							{
								_ref_beast: _ref_beast,
								_ref_target: _ref_adjacent
							}
						);
					}
				}

				//====================//
				//RESOLVE WAVE CRASH//
				//====================//
				if (array_length(_arr_moves) > 0){

					var _stct_move =
						_arr_moves[
							irandom(
								array_length(_arr_moves) - 1
							)
						];

					//================//
					//REPOSITION PAIR//
					//================//
					var _flag_repositioned =
						scr_battle_reposition_target(
							_stct_move._ref_beast,
							_stct_move._ref_target,
							false,
							false
						);

					//================//
					//WAVE CRASH VFX//
					//================//
					if (_flag_repositioned){

						scr_battle_vfx(
							_stct_move._ref_beast,
							spr_battle_vfx_weather_storming_wave_crash,
							undefined,
							undefined,
							0,
							0,
							1,
							0,
							snd_battle_weather_storming_wave_crash
						);
					}
				}

				//=================//
				//QUEUE LIGHTNING//
				//=================//
				_ref_status._str_storming_phase =
					"WAIT_LIGHTNING";

				_ref_status._ct_storming_delay =
					12;

				return undefined;
			}

			#endregion

			#region LIGHTNING PHASE

			//==================//
			//LIGHTNING PHASE//
			//==================//
			if (_ref_status._str_storming_phase == "LIGHTNING"){

				var _arr_beasts = [];

				//====================//
				//GET PLAYER BEASTS//
				//====================//
				if (instance_exists(obj_battle_player_controller)){

					var _list_player_beasts =
						obj_battle_player_controller._list_beasts_alive;

					if (ds_exists(_list_player_beasts,ds_type_list)){

						for (
							var _it_beast = 0;
							_it_beast < ds_list_size(_list_player_beasts);
							_it_beast++
						){

							var _ref_beast = ds_list_find_value(
								_list_player_beasts,
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

							array_push(
								_arr_beasts,
								_ref_beast
							);
						}
					}
				}

				//===================//
				//GET ENEMY BEASTS//
				//===================//
				if (instance_exists(obj_battle_enemy_controller)){

					var _list_enemy_beasts =
						obj_battle_enemy_controller._list_beasts_alive;

					if (ds_exists(_list_enemy_beasts,ds_type_list)){

						for (
							var _it_beast = 0;
							_it_beast < ds_list_size(_list_enemy_beasts);
							_it_beast++
						){

							var _ref_beast = ds_list_find_value(
								_list_enemy_beasts,
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

							array_push(
								_arr_beasts,
								_ref_beast
							);
						}
					}
				}

				//======================//
				//STRIKE RANDOM BEASTS//
				//======================//
				for (
					var _it_strike = 0;
					_it_strike < 2;
					_it_strike++
				){

					if (array_length(_arr_beasts) <= 0){
						break;
					}

					//================//
					//SELECT TARGET//
					//================//
					var _it_target =
						irandom(
							array_length(_arr_beasts) - 1
						);

					var _ref_lightning_target =
						_arr_beasts[_it_target];

					//========================//
					//PREVENT REPEATED TARGET//
					//========================//
					array_delete(
						_arr_beasts,
						_it_target,
						1
					);

					if (!instance_exists(_ref_lightning_target)){
						continue;
					}

					//===============//
					//LIGHTNING VFX//
					//===============//
					scr_battle_vfx(
						_ref_lightning_target,
						spr_battle_vfx_weather_storming_lightning_strike,
						undefined,
						undefined,
						0,
						0,
						1,
						0,
						snd_battle_weather_storming_lightning_strike
					);

					//==================//
					//LIGHTNING DAMAGE//
					//==================//
					scr_battle_damage_target(
						"FIXED",
						undefined,
						_ref_lightning_target,
						2
					);

					//===================//
					//APPLY STORMSTRUCK//
					//===================//
					if (
						instance_exists(_ref_lightning_target) &&
						_ref_lightning_target._str_list == "ALIVE" &&
						_ref_lightning_target._val_cur_hp > 0
					){

						scr_status_apply_dot(
							"STORMSTRUCK",
							_ref_lightning_target
						);
					}
				}

				//================//
				//RESET PHASE//
				//================//
				_ref_status._str_storming_phase =
					"READY";

				_ref_status._ct_storming_delay =
					0;

				//================//
				//UPDATE LIFETIME//
				//================//
				scr_status_tick_lifetime(
					_ref_status
				);

				if (ds_exists(global.list_statuses,ds_type_list)){

					scr_status_reposition(
						global.list_statuses
					);
				}
			}

			#endregion

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(
				_ref_status
			);

		break;
	}

	return undefined;
}