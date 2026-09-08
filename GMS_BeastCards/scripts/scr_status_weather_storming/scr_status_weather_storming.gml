//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_STORMING
// FUNCTION: Handles the Storming global Weather status.
//           At end of round, randomly repositions one adjacent Beast pair.
//           Then strikes 2 different random living Beasts for 2 NEU damage
//           and applies 1 Stormstruck to each surviving struck Beast.
//           Owns Storming start VFX, persistent VFX, and Weather ambience.
//
//===============================================================================//

function scr_status_weather_storming(_str_tag,_ref_status,_val_lifetime=undefined){

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

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"WEATHER: STORMING",
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

				//----------------------//
				//REFRESH WEATHER SOURCE//
				//----------------------//
				_ref_existing_status._ref_source_caster =
					global.ref_caster_beast;

				_ref_existing_status._ref_source_card =
					global.ref_cast_card;

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
				scr_status_weather_storming;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: STORMING";

			_ref_new_status._str_status_desc =
				"END OF ROUND: RANDOMLY REPOSITION 1 BEAST BY 1 POSITION. STRIKE 2 RANDOM BEASTS FOR 2 NEU DAMAGE AND APPLY 1 STORMSTRUCK.";

			_ref_new_status._spr_status =
				spr_status_weather_storming;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_stackable =
				false;
				
			//--------------------//
			//REPEAT PRESENTATION//
			//--------------------//
			_ref_new_status._str_storming_phase =
				"READY";

			_ref_new_status._ct_storming_delay =
				0;
				
			//--------------------//
			//STORE WEATHER SOURCE//
			//--------------------//
			_ref_new_status._ref_source_caster =
				global.ref_caster_beast;

			_ref_new_status._ref_source_card =
				global.ref_cast_card;

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

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(global.list_statuses);

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

			//=======================//
			//WAIT FOR LIGHTNING PHASE//
			//=======================//
			if (_ref_status._str_storming_phase == "WAIT_LIGHTNING"){

				if (_ref_status._ct_storming_delay > 0){

					_ref_status._ct_storming_delay--;

					return undefined;
				}

				_ref_status._str_storming_phase =
					"LIGHTNING";
			}

			//==================//
			//REPOSITION PHASE//
			//==================//
			if (_ref_status._str_storming_phase == "READY"){

				//===========================//
				//RANDOM ADJACENT REPOSITION//
				//===========================//
				var _arr_moves = [];

				var _arr_team_lists = [
					obj_battle_player_controller._list_beasts_alive,
					obj_battle_enemy_controller._list_beasts_alive
				];

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

						var _ref_beast =
							ds_list_find_value(
								_list_team,
								_it_beast
							);

						var _ref_adjacent =
							ds_list_find_value(
								_list_team,
								_it_beast + 1
							);

						if (
							!instance_exists(_ref_beast) ||
							!instance_exists(_ref_adjacent)
						){
							continue;
						}

						//---------------------//
						//CHECK MOVEMENT LOCKS//
						//---------------------//
						if (
							!scr_battle_can_reposition(_ref_beast) ||
							!scr_battle_can_reposition(_ref_adjacent)
						){
							continue;
						}

						var _stct_move = {
							_ref_beast : _ref_beast,
							_ref_target : _ref_adjacent
						};

						array_push(
							_arr_moves,
							_stct_move
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

					var _stct_source_card =
						undefined;

					if (
						instance_exists(_ref_status._ref_source_card) &&
						is_struct(_ref_status._ref_source_card._ref_card)
					){

						_stct_source_card =
							_ref_status._ref_source_card._ref_card;
					}

					//----------------//
					//REPOSITION PAIR//
					//----------------//
					var _flag_repositioned =
						scr_battle_reposition_target(
							_stct_source_card,
							_stct_move._ref_beast,
							_stct_move._ref_target,
							false,
							false
						);

					//----------------//
					//WAVE CRASH VFX//
					//----------------//
					if (_flag_repositioned){

						scr_battle_vfx(
							_stct_move._ref_beast,
							spr_battle_vfx_event_storming_wave_crash,
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

				//===================//
				//QUEUE LIGHTNING//
				//===================//
				_ref_status._str_storming_phase =
					"WAIT_LIGHTNING";

				_ref_status._ct_storming_delay =
					12;

				return undefined;
			}

			//==================//
			//LIGHTNING PHASE//
			//==================//
			if (_ref_status._str_storming_phase == "LIGHTNING"){

				//======================//
				//STORE GLOBAL CONTEXT//
				//======================//
				var _ref_original_card =
					global.ref_cast_card;

				var _ref_original_caster =
					global.ref_caster_beast;

				var _ref_original_target =
					global.ref_target_beast;

				//=====================//
				//SET WEATHER CONTEXT//
				//=====================//
				var _ref_weather_card =
					_ref_status._ref_source_card;

				var _ref_weather_caster =
					_ref_status._ref_source_caster;

				var _flag_weather_context_valid =
					instance_exists(_ref_weather_card) &&
					instance_exists(_ref_weather_caster) &&
					is_struct(_ref_weather_card._ref_card);

				if (_flag_weather_context_valid){

					global.ref_cast_card =
						_ref_weather_card;

					global.ref_caster_beast =
						_ref_weather_caster;

					_ref_weather_card._arr_vfx_hit_context =
						[];
				}

				//==================//
				//GET LIVING BEASTS//
				//==================//
				var _list_beasts =
					ds_list_create();

				//--------------------//
				//GET PLAYER BEASTS//
				//--------------------//
				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(obj_battle_player_controller._list_beasts_alive);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							obj_battle_player_controller._list_beasts_alive,
							_it_beast
						);

					if (
						instance_exists(_ref_beast) &&
						_ref_beast._str_list == "ALIVE" &&
						_ref_beast._val_cur_hp > 0
					){

						ds_list_add(
							_list_beasts,
							_ref_beast
						);
					}
				}

				//-------------------//
				//GET ENEMY BEASTS//
				//-------------------//
				for (
					var _it_beast = 0;
					_it_beast < ds_list_size(obj_battle_enemy_controller._list_beasts_alive);
					_it_beast++
				){

					var _ref_beast =
						ds_list_find_value(
							obj_battle_enemy_controller._list_beasts_alive,
							_it_beast
						);

					if (
						instance_exists(_ref_beast) &&
						_ref_beast._str_list == "ALIVE" &&
						_ref_beast._val_cur_hp > 0
					){

						ds_list_add(
							_list_beasts,
							_ref_beast
						);
					}
				}

				//=======================//
				//LIGHTNING PRESENTATION//
				//=======================//
				var _stct_lightning_presentation = {
					_spr_vfx_override : spr_battle_vfx_event_storming_lightning_strike,
					_snd_sfx_override : snd_battle_weather_storming_lightning_strike
				};

				//=======================//
				//FORCE NEUTRAL DAMAGE//
				//=======================//
				var _str_original_stat =
					undefined;

				if (_flag_weather_context_valid){

					_str_original_stat =
						_ref_weather_card._ref_card._str_card_stat;

					_ref_weather_card._ref_card._str_card_stat =
						"NEU";
				}

				//======================//
				//STRIKE RANDOM BEASTS//
				//======================//
				if (_flag_weather_context_valid){

					for (
						var _it_strike = 0;
						_it_strike < 2;
						_it_strike++
					){

						if (ds_list_size(_list_beasts) <= 0){
							break;
						}

						//----------------//
						//SELECT TARGET//
						//----------------//
						var _it_target =
							irandom(
								ds_list_size(_list_beasts) - 1
							);

						var _ref_lightning_target =
							ds_list_find_value(
								_list_beasts,
								_it_target
							);

						//-------------------------//
						//PREVENT REPEATED TARGET//
						//-------------------------//
						ds_list_delete(
							_list_beasts,
							_it_target
						);

						if (!instance_exists(_ref_lightning_target)){
							continue;
						}

						//------------------//
						//SET STATUS TARGET//
						//------------------//
						global.ref_target_beast =
							_ref_lightning_target;

						//----------------//
						//LIGHTNING DAMAGE//
						//----------------//
						scr_battle_damage_target(
							2,
							_ref_lightning_target,
							_stct_lightning_presentation
						);

						//-------------------//
						//APPLY STORMSTRUCK//
						//-------------------//
						if (
							instance_exists(_ref_lightning_target) &&
							_ref_lightning_target._str_list == "ALIVE" &&
							_ref_lightning_target._val_cur_hp > 0
						){

							global.ref_target_beast =
								_ref_lightning_target;

							scr_status_apply_dot(
								"STORMSTRUCK"
							);
						}
					}
				}

				//---------------------//
				//RESTORE DAMAGE STAT//
				//---------------------//
				if (
					_flag_weather_context_valid &&
					_str_original_stat != undefined
				){

					_ref_weather_card._ref_card._str_card_stat =
						_str_original_stat;
				}

				//---------------//
				//DESTROY LIST//
				//---------------//
				ds_list_destroy(
					_list_beasts
				);

				//======================//
				//RESTORE GLOBAL CONTEXT//
				//======================//
				global.ref_cast_card =
					_ref_original_card;

				global.ref_caster_beast =
					_ref_original_caster;

				global.ref_target_beast =
					_ref_original_target;

				//----------------//
				//RESET PHASE//
				//----------------//
				_ref_status._str_storming_phase =
					"READY";

				_ref_status._ct_storming_delay =
					0;

				//----------------//
				//TICK LIFETIME//
				//----------------//
				scr_status_tick_lifetime(
					_ref_status
				);

				scr_status_reposition(
					global.list_statuses
				);
			}

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

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