//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_STORMING
// FUNCTION: Handles the Storming global Weather status.
//           Unstackable Timed.
//           Lifetime: 5 rounds.
//           End of round:
//           1. Randomly reposition 1 Beast by 1 valid adjacent position.
//           2. Strike 2 random living Beasts for 2 NEU damage.
//           3. Apply 1 Stormstruck to each surviving struck Beast.
//
//===============================================================================//

function scr_status_weather_storming(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			//----------------//
			//DEFAULT LENGTH//
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
				scr_check_for_status(
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

			//----------------------//
			//CLEAR CURRENT WEATHER//
			//----------------------//
			scr_clear_weather();

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

			_ref_new_status._scr_status =
				scr_status_weather_storming;

			_ref_new_status._ref_host =
				undefined;

			//--------------------//
			//STORE WEATHER SOURCE//
			//--------------------//
			_ref_new_status._ref_source_caster =
				global.ref_caster_beast;

			_ref_new_status._ref_source_card =
				global.ref_cast_card;

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: STORMING";

			_ref_new_status._str_status_desc =
				"END OF ROUND: RANDOMLY REPOSITION 1 BEAST BY 1 POSITION. STRIKE 2 RANDOM BEASTS FOR 2 NEU DMG AND APPLY 1 STORMSTRUCK.";

			_ref_new_status._spr_status =
				spr_status_weather_storming;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._ct_status_stacks =
				1;

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
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

			//----------------//
			//PLAY WEATHER VFX//
			//----------------//

			scr_reposition_statuses(
				global.list_statuses
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//----------------------//
			//STORE GLOBAL CONTEXT//
			//----------------------//
			var _ref_original_card =
				global.ref_cast_card;

			var _ref_original_caster =
				global.ref_caster_beast;

			var _ref_original_target =
				global.ref_target_beast;

			//----------------------//
			//RESTORE WEATHER SOURCE//
			//----------------------//
			global.ref_cast_card =
				_ref_status._ref_source_card;

			global.ref_caster_beast =
				_ref_status._ref_source_caster;


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
						!scr_can_reposition(_ref_beast) ||
						!scr_can_reposition(_ref_adjacent)
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

			//----------------------//
			//SELECT RANDOM MOVEMENT//
			//----------------------//
			if (array_length(_arr_moves) > 0){

				var _stct_move =
					_arr_moves[
						irandom(
							array_length(_arr_moves) - 1
						)
					];

				var _stct_source_card =
					undefined;

				if (instance_exists(_ref_status._ref_source_card)){

					_stct_source_card =
						_ref_status
							._ref_source_card
							._ref_card;
				}

				scr_reposition_target(
					_stct_source_card,
					_stct_move._ref_beast,
					_stct_move._ref_target
				);
			}


			//================//
			//LIGHTNING STRIKES//
			//================//

			//------------------//
			//BUILD BEAST LIST//
			//------------------//
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
					_ref_beast._val_cur_hp > 0
				){
					ds_list_add(
						_list_beasts,
						_ref_beast
					);
				}
			}

			//----------------------//
			//STRIKE RANDOM BEASTS//
			//----------------------//
			for (var _it_strike = 0; _it_strike < 2; _it_strike++){

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

				//----------------//
				//SET STATUS TARGET//
				//----------------//
				global.ref_target_beast =
					_ref_lightning_target;

				//----------------//
				//LIGHTNING DAMAGE//
				//----------------//
				scr_damage_target(
					2,
					_ref_lightning_target
				);

				//----------------//
				//PLAY LIGHTNING VFX//
				//----------------//

				//-------------------//
				//APPLY STORMSTRUCK//
				//-------------------//
				if (
					instance_exists(_ref_lightning_target) &&
					_ref_lightning_target._val_cur_hp > 0
				){

					global.ref_target_beast =
						_ref_lightning_target;

					scr_apply_dot_status(
						"STORMSTRUCK"
					);
				}
			}

			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(
				_list_beasts
			);

			//----------------------//
			//RESTORE GLOBAL CONTEXT//
			//----------------------//
			global.ref_cast_card =
				_ref_original_card;

			global.ref_caster_beast =
				_ref_original_caster;

			global.ref_target_beast =
				_ref_original_target;

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				global.list_statuses
			);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//----------------//
			//CLEAR WEATHER VFX//
			//----------------//

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}