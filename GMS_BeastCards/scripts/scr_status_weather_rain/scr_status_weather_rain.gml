//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_RAIN
// FUNCTION: Handles Rain Weather.
//
//           While active:
//           - Cerulean card damage is increased by 25%.
//
//           At the end of each round:
//           - Heal 1 random living Beast for 3 HP.
//           - Cleanse 1 Debuff from 1 random living Beast.
//
//           Heal and cleanse targets are rolled independently.
//
//===============================================================================//
function scr_status_weather_rain(
	_str_tag,
	_ref_status,
	_val_lifetime=undefined
){

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
					"WEATHER: RAIN",
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

			_ref_new_status._scr_status =
				scr_status_weather_rain;

			//--------------------------------//
			//GLOBAL STATUS HAS NO BEAST HOST//
			//--------------------------------//
			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: RAIN";

			_ref_new_status._str_status_desc =
				"CERULEAN DAMAGE +25%. END OF ROUND: HEAL 1 RANDOM BEAST FOR 3 HP AND CLEANSE 1 DEBUFF FROM 1 RANDOM BEAST.";

			_ref_new_status._spr_status =
				spr_status_weather_rain;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

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

			//-------------------//
			//CHANGE BACKGROUND//
			//-------------------//
			var _ref_layer =
				layer_get_id(
					"bly_weather"
				);

			layer_background_change(
				_ref_layer,
				spr_scene_fx_rain
			);

			layer_set_visible(
				_ref_layer,
				true
			);

			//-------------------------//
			//POSITION GLOBAL STATUS//
			//-------------------------//
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


			//------------------//
			//BUILD BEAST LIST//
			//------------------//
			var _list_living =
				ds_list_create();

			//--------------------//
			//GET PLAYER BEASTS//
			//--------------------//
			for (
				var _it_beast = 0;
				_it_beast <
					ds_list_size(
						obj_battle_player_controller
							._list_beasts_alive
					);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						obj_battle_player_controller
							._list_beasts_alive,
						_it_beast
					);

				if (
					instance_exists(_ref_beast) &&
					_ref_beast._val_cur_hp > 0
				){

					ds_list_add(
						_list_living,
						_ref_beast
					);
				}
			}

			//-------------------//
			//GET ENEMY BEASTS//
			//-------------------//
			for (
				var _it_beast = 0;
				_it_beast <
					ds_list_size(
						obj_battle_enemy_controller
							._list_beasts_alive
					);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						obj_battle_enemy_controller
							._list_beasts_alive,
						_it_beast
					);

				if (
					instance_exists(_ref_beast) &&
					_ref_beast._val_cur_hp > 0
				){

					ds_list_add(
						_list_living,
						_ref_beast
					);
				}
			}


			//-------------------//
			//RANDOM BEAST HEAL//
			//-------------------//
			if (ds_list_size(_list_living) > 0){

				var _ref_heal_target =
					ds_list_find_value(
						_list_living,
						irandom(
							ds_list_size(_list_living) - 1
						)
					);

				scr_heal_target(
					3,
					_ref_heal_target
				);
			}


			//----------------------//
			//RANDOM CLEANSE TARGET//
			//----------------------//
			if (ds_list_size(_list_living) > 0){

				var _ref_cleanse_target =
					ds_list_find_value(
						_list_living,
						irandom(
							ds_list_size(_list_living) - 1
						)
					);

				var _arr_debuffs =
					[];

				//-------------------------//
				//FIND CLEANSEABLE DEBUFFS//
				//-------------------------//
				for (
					var _it_status = 0;
					_it_status <
						ds_list_size(
							_ref_cleanse_target._list_statuses
						);
					_it_status++
				){

					var _ref_cleanse_status =
						ds_list_find_value(
							_ref_cleanse_target._list_statuses,
							_it_status
						);

					if (!instance_exists(_ref_cleanse_status)){
						continue;
					}

					if (
						_ref_cleanse_status._str_status_type
						!= "DEBUFF"
					){
						continue;
					}

					if (
						_ref_cleanse_status
							._flag_status_uncleansable
					){
						continue;
					}

					array_push(
						_arr_debuffs,
						_ref_cleanse_status
					);
				}


				//----------------//
				//CLEANSE DEBUFF//
				//----------------//
				if (array_length(_arr_debuffs) > 0){

					var _ref_cleanse_status =
						_arr_debuffs[
							irandom(
								array_length(_arr_debuffs) - 1
							)
						];

					var _str_status_name =
						_ref_cleanse_status
							._str_status_name;

					if (
						_ref_cleanse_status._scr_status
						!= undefined
					){

						_ref_cleanse_status._scr_status(
							"DEATH",
							_ref_cleanse_status
						);
					}
					else{

						scr_destroy_status(
							_ref_cleanse_status
						);
					}

					//------------------//
					//CLEANSE NOTIFIER//
					//------------------//
					scr_spawn_popup_scrolling(
						"TEXT",
						"CLEANSED " +
							_str_status_name,
						undefined,
						c_green,
						_ref_cleanse_target.x +
							irandom_range(-32,32),
						_ref_cleanse_target.y -
							24 +
							irandom_range(-32,32)
					);
				}
				else{

					//------------------//
					//CLEANSE NOTIFIER//
					//------------------//
					scr_spawn_popup_scrolling(
						"TEXT",
						"NO DEBUFF TO CLEANSE",
						undefined,
						c_green,
						_ref_cleanse_target.x +
							irandom_range(-32,32),
						_ref_cleanse_target.y -
							24 +
							irandom_range(-32,32)
					);
				}

				scr_reposition_statuses(
					_ref_cleanse_target
				);
			}


			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(
				_list_living
			);


			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			//-------------------------//
			//POSITION GLOBAL STATUS//
			//-------------------------//
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

			//------------------//
			//CLEAR BACKGROUND//
			//------------------//
			var _ref_layer =
				layer_get_id(
					"bly_weather"
				);

			layer_background_change(
				_ref_layer,
				spr_bg_blank
			);

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
