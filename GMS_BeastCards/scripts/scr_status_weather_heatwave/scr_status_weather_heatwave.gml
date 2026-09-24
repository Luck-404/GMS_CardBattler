//===============================================================================//
//
// SCRIPT: SCR_STATUS_WEATHER_HEATWAVE
// FUNCTION: Handles the Heatwave global Weather Status.
//
//           While active:
//           Vermilion Card damage is increased by 25%.
//           Burn deals 1 additional damage per stack.
//           The Char threshold is reduced by 1.
//
//           Lifetime: 5 rounds.
//           Owns the Weather start and persistent VFX.
//
// ARGUMENTS: _str_tag selects the Status action.
//            _ref_status references the existing Heatwave Status.
//            _val_lifetime optionally overrides its duration.
// RETURNS: Active Heatwave Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_weather_heatwave(_str_tag,_ref_status,_val_lifetime=undefined){

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
				"WEATHER: HEATWAVE",
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

			//===================//
			//INITIALIZE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_weather_heatwave;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "WEATHER";
			_ref_new_status._str_status_name = "WEATHER: HEATWAVE";

			_ref_new_status._str_status_desc = "Weather. Vermilion damage is increased by 25%. Burn deals 1 additional damage per stack. Reduce the Char threshold by 1. Lifetime: 5 rounds.";

			_ref_new_status._spr_status = spr_status_weather_heatwave;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			//================//
			//HEATWAVE START//
			//================//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_weather_heatwave_start,
				room_width * 0.5,
				room_height * 0.5,
				0,
				0,
				1,
				0,
				undefined
			);

			//=======================//
			//PERSISTENT HEATWAVE VFX//
			//=======================//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent_loop(
				spr_battle_vfx_weather_heatwave_persist,
				room_width * 0.5,
				room_height * 0.5,
				1,
				"ily_weather_fx"
			);

			//================//
			//REPOSITION STATUS//
			//================//
			scr_status_reposition(global.list_statuses);

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

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//================//
			//DESTROY WEATHER//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}