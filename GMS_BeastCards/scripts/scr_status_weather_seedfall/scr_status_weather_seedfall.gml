//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_SEEDFALL
// FUNCTION: Handles the SEEDFALL global Weather status.
//           Unstackable Timed.
//           Grants +25% Viridian damage while active.

//
//===============================================================================//
function scr_status_weather_seedfall(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status(
				"WEATHER: SEEDFALL",
				global.list_statuses
			);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._scr_status = scr_status_weather_seedfall;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_name = "WEATHER: SEEDFALL";

			_ref_new_status._str_status_desc =
				"VIRIDIAN DAMAGE +25%. END OF ROUND: SELECT 2 RANDOM BEASTS, HEAL EACH 1, AND SUMMON A RANDOM VIRIDIAN MINION ON EACH.";

			_ref_new_status._spr_status = spr_status_weather_seedfall;

			_ref_new_status._str_trigger_region = "END";

			_ref_new_status._str_status_type = "WEATHER";

			_ref_new_status._ct_status_stacks = 1;

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(_ref_new_status,_val_lifetime,false,false);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(global.list_statuses,_ref_new_status);

			//-------------------//
			//CHANGE BACKGROUND//
			//-------------------//
			var _ref_layer = layer_get_id("bly_weather");

			layer_background_change(_ref_layer,spr_scene_fx_seedfall);

			scr_reposition_statuses(global.list_statuses);

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
			var _list_beasts = ds_list_create();

			//--------------------//
			//GET PLAYER BEASTS//
			//--------------------//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(obj_battle_player_controller._list_beasts_alive);
				_it_beast++
			){

				var _ref_beast = ds_list_find_value(
					obj_battle_player_controller._list_beasts_alive,
					_it_beast
				);

				if (instance_exists(_ref_beast)){
					ds_list_add(_list_beasts,_ref_beast);
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

				var _ref_beast = ds_list_find_value(
					obj_battle_enemy_controller._list_beasts_alive,
					_it_beast
				);

				if (instance_exists(_ref_beast)){
					ds_list_add(_list_beasts,_ref_beast);
				}
			}

			//-------------------------//
			//TRIGGER TWO RANDOM BEASTS//
			//-------------------------//
			for (var _it_spawn = 0; _it_spawn < 2; _it_spawn++){

				if (ds_list_size(_list_beasts) <= 0){
					break;
				}

				var _ref_target = ds_list_find_value(
					_list_beasts,
					irandom(ds_list_size(_list_beasts) - 1)
				);

				if (!instance_exists(_ref_target)){
					continue;
				}

				//-----------//
				//HEAL BY 1//
				//-----------//
				scr_heal_target(1,_ref_target);

				//----------------------//
				//GET RANDOM VIRIDIAN//
				//----------------------//
				var _it_minion = irandom(
					ds_list_size(global.list_pool_viridian_minions) - 1
				);

				var _str_minion = ds_list_find_value(
					global.list_pool_viridian_minions,
					_it_minion
				);

				//--------------//
				//SUMMON MINION//
				//--------------//
				scr_init_minion(_str_minion,undefined,undefined,_ref_target);
			}

			//---------------//
			//DESTROY LIST//
			//---------------//
			ds_list_destroy(_list_beasts);

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(global.list_statuses);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_layer = layer_get_id("bly_event");

			layer_background_change(_ref_layer,spr_bg_blank);

			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}