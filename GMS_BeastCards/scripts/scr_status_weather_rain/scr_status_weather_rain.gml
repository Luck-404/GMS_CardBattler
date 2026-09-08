//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_RAIN
// FUNCTION: Handles the Rain global Weather status.
//           Increases Cerulean damage by 25% while active.
//           At end of round, heals 1 random living Beast for 3 HP.
//           Independently cleanses 1 Debuff from 1 random living Beast.
//           Owns Rain start VFX, persistent VFX, and Weather ambience.
//
//===============================================================================//

function scr_status_weather_rain(_str_tag,_ref_status,_val_lifetime=undefined){

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

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status =
				scr_status_weather_rain;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: RAIN";

			_ref_new_status._str_status_desc =
				"CERULEAN DAMAGE +25%. END OF ROUND: HEAL 1 RANDOM LIVING BEAST FOR 3 HP AND CLEANSE 1 DEBUFF FROM 1 INDEPENDENTLY SELECTED RANDOM LIVING BEAST.";

			_ref_new_status._spr_status =
				spr_status_weather_rain;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_stackable =
				false;

			_ref_new_status._str_trigger_region =
				"END";

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

			//=================//
			//RAIN START VFX//
			//=================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_weather_rain_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_weather_rain_start
			);

			//======================//
			//PERSISTENT RAIN VFX//
			//======================//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent_loop(
					spr_battle_vfx_weather_rain_persist,
					room_width * 0.5,
					room_height * 0.5,
					1,
					"ily_weather_fx"
				);

			//================//
			//RAIN AMBIENCE//
			//================//
			scr_status_start_persistent_audio(
				_ref_new_status,
				bgm_battle_weather_rain,
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

			//--------------------------------//
//BUILD LIVING BEAST TARGET LIST//
//--------------------------------//
var _list_living =
	ds_list_create();

//--------------------//
//GET PLAYER BEASTS//
//--------------------//
for (
	var _it_beast = 0;
	_it_beast < ds_list_size(
		obj_battle_player_controller._list_beasts_alive
	);
	_it_beast++
){

	var _ref_beast =
		ds_list_find_value(
			obj_battle_player_controller._list_beasts_alive,
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

	ds_list_add(
		_list_living,
		_ref_beast
	);
}

			//-------------------//
			//GET ENEMY BEASTS//
			//-------------------//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(
					obj_battle_enemy_controller._list_beasts_alive
				);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						obj_battle_enemy_controller._list_beasts_alive,
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

				ds_list_add(
					_list_living,
					_ref_beast
				);
			}

			//===================//
			//RANDOM BEAST HEAL//
			//===================//
			if (ds_list_size(_list_living) > 0){

				var _ref_heal_target =
					ds_list_find_value(
						_list_living,
						irandom(
							ds_list_size(_list_living) - 1
						)
					);

				var _ref_original_target =
					global.ref_target_beast;

				global.ref_target_beast =
					_ref_heal_target;

				scr_battle_heal_target(3,
					_ref_heal_target
				);

				global.ref_target_beast =
					_ref_original_target;
			}

			//======================//
			//RANDOM DEBUFF CLEANSE//
			//======================//
			if (ds_list_size(_list_living) > 0){

				var _ref_cleanse_target =
					ds_list_find_value(
						_list_living,
						irandom(
							ds_list_size(_list_living) - 1
						)
					);

				scr_status_cleanse_type(
					_ref_cleanse_target,
					"DEBUFF",
					1
				);
			}

			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(_list_living);

			//----------------//
			//TICK LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(global.list_statuses);

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
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}