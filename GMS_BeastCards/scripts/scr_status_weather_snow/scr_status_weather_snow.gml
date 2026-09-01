//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_SNOW
// FUNCTION: Handles the Snow global Weather status.
//           Unstackable Timed.
//           Lifetime: 5 rounds.
//           End of round:
//           1. Apply 1 Frostbite to every living Beast without Armor.
//           2. Any Beast with at least 3 Frostbite consumes 3 Frostbite
//              and gains 1 Frostburn.
//
//===============================================================================//

function scr_status_weather_snow(_str_tag,_ref_status,_val_lifetime=undefined){

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
					"WEATHER: SNOW",
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
				scr_status_weather_snow;

			_ref_new_status._ref_host =
				undefined;

			_ref_new_status._str_status_type =
				"WEATHER";

			_ref_new_status._str_status_name =
				"WEATHER: SNOW";

			_ref_new_status._str_status_desc =
				"END OF ROUND: BEASTS WITHOUT ARMOR GAIN 1 FROSTBITE. 3 FROSTBITE BECOMES 1 FROSTBURN.";

			_ref_new_status._spr_status =
				spr_status_weather_snow;

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

			//-------------------//
			//CHANGE BACKGROUND//
			//-------------------//

			var _ref_layer =
				layer_get_id("bly_weather");

			layer_background_change(
				_ref_layer,
				spr_scene_fx_snow
			);

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

			//----------------//
			//BUILD BEAST LIST//
			//----------------//
			var _list_beasts =
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

				if (instance_exists(_ref_beast)){

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

				if (instance_exists(_ref_beast)){

					ds_list_add(
						_list_beasts,
						_ref_beast
					);
				}
			}

			//----------------------//
			//STORE ORIGINAL TARGET//
			//----------------------//
			var _ref_original_target =
				global.ref_target_beast;

			//=============================//
			//PASS 1: APPLY FROSTBITE//
			//=============================//

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

				if (_ref_beast._val_cur_hp <= 0){
					continue;
				}

				//----------------//
				//MUST HAVE NO ARMOR//
				//----------------//
				if (_ref_beast._val_armor > 0){
					continue;
				}

				global.ref_target_beast =
					_ref_beast;

				scr_apply_dot_status(
					"FROSTBITE"
				);
			}

			//================================//
			//PASS 2: CONVERT TO FROSTBURN//
			//================================//

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

				if (_ref_beast._val_cur_hp <= 0){
					continue;
				}

				var _ref_frostbite =
					scr_check_for_status(
						"FROSTBITE",
						_ref_beast
					);

				if (_ref_frostbite == -1){
					continue;
				}

				if (_ref_frostbite._ct_status_stacks < 3){
					continue;
				}

				//--------------------//
				//CONSUME FROSTBITE//
				//--------------------//
				var _ct_consumed =
					scr_consume_frostbite(
						_ref_beast,
						3
					);

				if (_ct_consumed < 3){
					continue;
				}

				//----------------//
				//APPLY FROSTBURN//
				//----------------//
				global.ref_target_beast =
					_ref_beast;

				scr_apply_dot_status(
					"FROSTBURN"
				);
			}

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast =
				_ref_original_target;

			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(
				_list_beasts
			);

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

			//------------------//
			//CLEAR BACKGROUND//
			//------------------//
			var _ref_layer =
				layer_get_id("bly_weather");

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