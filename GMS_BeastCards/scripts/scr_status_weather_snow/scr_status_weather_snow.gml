//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_SNOW
// FUNCTION: Handles the Snow global Weather Status.
//           At end of round, living Beasts without Armor gain 1 Frostbite.
//           Living Beasts with at least 3 Frostbite attempt to gain 1 Frostburn;
//           on successful application, 3 Frostbite are consumed.
//           Owns Snow start VFX, persistent VFX, and Weather ambience.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Status, and _val_lifetime optionally sets its duration.
// RETURNS: The active Snow Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_weather_snow(_str_tag,_ref_status,_val_lifetime=undefined){

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

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"WEATHER: SNOW",
				global.list_statuses
			);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
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

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_weather_snow;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "WEATHER";
			_ref_new_status._str_status_name = "WEATHER: SNOW";
			_ref_new_status._str_status_desc = "END OF ROUND: BEASTS WITHOUT ARMOR GAIN 1 FROSTBITE. 3 FROSTBITE BECOMES 1 FROSTBURN.";

			_ref_new_status._spr_status = spr_status_weather_snow;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//=================//
			//SNOW START VFX//
			//=================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_weather_snow_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				snd_battle_weather_snow_start
			);

			//======================//
			//PERSISTENT SNOW VFX//
			//======================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent_loop(
				spr_battle_vfx_weather_snow_persist,
				room_width * 0.5,
				room_height * 0.5,
				1,
				"ily_weather_fx"
			);

			//================//
			//SNOW AMBIENCE//
			//================//
			scr_status_start_persistent_audio(
				_ref_new_status,
				bgm_battle_weather_snow,
				0.25
			);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//===================//
			//BUILD BEAST ARRAY//
			//===================//
			var _arr_beasts = [];

			//--------------------//
			//GET PLAYER BEASTS//
			//--------------------//
			if (instance_exists(obj_battle_player_controller)){

				var _list_player_beasts = obj_battle_player_controller._list_beasts_alive;

				if (ds_exists(_list_player_beasts,ds_type_list)){

					for (var _it_beast = 0;_it_beast < ds_list_size(_list_player_beasts);_it_beast++){

						var _ref_beast = ds_list_find_value(_list_player_beasts,_it_beast);

						if (!instance_exists(_ref_beast)){
							continue;
						}

						if (
							_ref_beast._str_list != "ALIVE" ||
							_ref_beast._val_cur_hp <= 0
						){
							continue;
						}

						array_push(_arr_beasts,_ref_beast);
					}
				}
			}

			//-------------------//
			//GET ENEMY BEASTS//
			//-------------------//
			if (instance_exists(obj_battle_enemy_controller)){

				var _list_enemy_beasts = obj_battle_enemy_controller._list_beasts_alive;

				if (ds_exists(_list_enemy_beasts,ds_type_list)){

					for (var _it_beast = 0;_it_beast < ds_list_size(_list_enemy_beasts);_it_beast++){

						var _ref_beast = ds_list_find_value(_list_enemy_beasts,_it_beast);

						if (!instance_exists(_ref_beast)){
							continue;
						}

						if (
							_ref_beast._str_list != "ALIVE" ||
							_ref_beast._val_cur_hp <= 0
						){
							continue;
						}

						array_push(_arr_beasts,_ref_beast);
					}
				}
			}

			//----------------------//
			//STORE ORIGINAL TARGET//
			//----------------------//
			var _ref_original_target = global.ref_target_beast;

			//=========================//
			//PASS 1: APPLY FROSTBITE//
			//=========================//
			for (var _it_beast = 0;_it_beast < array_length(_arr_beasts);_it_beast++){

				var _ref_beast = _arr_beasts[_it_beast];

				if (!instance_exists(_ref_beast)){
					continue;
				}

				if (_ref_beast._val_cur_hp <= 0){
					continue;
				}

				//-------------------//
				//ARMOR BLOCKS SNOW//
				//-------------------//
				if (_ref_beast._val_armor > 0){
					continue;
				}

				//----------------//
				//APPLY FROSTBITE//
				//----------------//
				global.ref_target_beast = _ref_beast;

				scr_status_apply_dot("FROSTBITE");
			}

			//============================//
			//PASS 2: CONVERT FROSTBITE//
			//============================//
			for (var _it_beast = 0;_it_beast < array_length(_arr_beasts);_it_beast++){

				var _ref_beast = _arr_beasts[_it_beast];

				if (!instance_exists(_ref_beast)){
					continue;
				}

				if (_ref_beast._val_cur_hp <= 0){
					continue;
				}

				//----------------//
				//GET FROSTBITE//
				//----------------//
				var _ref_frostbite = scr_status_check("FROSTBITE",_ref_beast);

				if (
					_ref_frostbite == -1 ||
					!instance_exists(_ref_frostbite)
				){
					continue;
				}

				if (_ref_frostbite._ct_status_stacks < 3){
					continue;
				}

				//----------------//
				//APPLY FROSTBURN//
				//----------------//
				global.ref_target_beast = _ref_beast;

				var _ref_frostburn = scr_status_apply_dot("FROSTBURN");

				if (!instance_exists(_ref_frostburn)){
					continue;
				}

				//-------------------//
				//CONSUME FROSTBITE//
				//-------------------//
				scr_status_consume_frostbite(
					_ref_beast,
					3
				);
			}

			//================//
			//RESTORE TARGET//
			//================//
			global.ref_target_beast = _ref_original_target;

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			if (ds_exists(global.list_statuses,ds_type_list)){
				scr_status_reposition(global.list_statuses);
			}

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}