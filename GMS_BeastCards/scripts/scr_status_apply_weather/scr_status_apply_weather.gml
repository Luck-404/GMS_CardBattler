//===============================================================================//
//
// SCRIPT: SCR_STATUS_APPLY_WEATHER
// FUNCTION: Applies or refreshes a global Weather Status.
//           Reapplying the same Weather refreshes its lifetime.
//           Applying a different Weather removes all current Weather first.
//           Logs successful Weather starts and refreshes.
//
//           ACTIVE WEATHER:
//           - SEEDFALL
//           - RAIN
//           - SNOW
//           - STORMING
//
//           PLANNED:
//           - HEATWAVE
//           - FIRESTORM
//
// ARGUMENTS: _str_weather_name is the Weather ID to apply and _val_lifetime
//            optionally overrides that Weather's default duration.
// RETURNS: The applied Weather Status reference, or undefined if application fails.
//
//===============================================================================//

function scr_status_apply_weather(_str_weather_name,_val_lifetime=undefined){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return undefined;
	}

	//==========================//
	//VALIDATE REQUESTED WEATHER//
	//==========================//
	switch (_str_weather_name){

		case "SEEDFALL":
		case "RAIN":
		case "SNOW":
		case "STORMING":
		break;

		default:
			return undefined;
	}

	var _ref_status = undefined;
	var _str_requested_weather = "WEATHER: " + _str_weather_name;
	var _c_popup = c_aqua;

	//=======================//
	//CHECK CURRENT WEATHER//
	//=======================//
	var _flag_same_weather_active = false;

	for (var _it_status = 0;_it_status < ds_list_size(global.list_statuses);_it_status++){

		var _ref_check_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_check_status)){
			continue;
		}

		if (_ref_check_status._str_status_type != "WEATHER"){
			continue;
		}

		if (_ref_check_status._str_status_name == _str_requested_weather){

			_flag_same_weather_active = true;

			break;
		}
	}

	//===========================//
	//REPLACE DIFFERENT WEATHER//
	//===========================//
	if (!_flag_same_weather_active){
		scr_status_clear_weather();
	}

	//================//
	//APPLY WEATHER//
	//================//
	switch (_str_weather_name){

		//==========//
		//SEEDFALL//
		//==========//
		case "SEEDFALL":

			_ref_status = scr_status_weather_seedfall(
				"APPLY",
				undefined,
				_val_lifetime
			);

			_c_popup = c_black;

		break;

		//======//
		//RAIN//
		//======//
		case "RAIN":

			_ref_status = scr_status_weather_rain(
				"APPLY",
				undefined,
				_val_lifetime
			);

		break;

		//======//
		//SNOW//
		//======//
		case "SNOW":

			_ref_status = scr_status_weather_snow(
				"APPLY",
				undefined,
				_val_lifetime
			);

		break;

		//==========//
		//STORMING//
		//==========//
		case "STORMING":

			_ref_status = scr_status_weather_storming(
				"APPLY",
				undefined,
				_val_lifetime
			);

		break;
	}

	//====================//
	//WEATHER FEEDBACK//
	//====================//
	if (instance_exists(_ref_status)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			_str_requested_weather,
			undefined,
			_c_popup,
			room_width * 0.5,
			room_height * 0.5
		);
	}

	//==================//
	//DEBUG APPLICATION//
	//==================//
	if (instance_exists(_ref_status)){

		var _str_lifetime = "INFINITE";

		if (!_ref_status._flag_status_infinite){
			_str_lifetime = string(_ref_status._val_status_lifetime);
		}

		scr_debug_log(
			"BATTLE",
			"WEATHER",
			_ref_status,
			(_flag_same_weather_active ? "WEATHER REFRESHED: " : "WEATHER STARTED: ") +
			string_upper(_str_weather_name) +
			" | LIFETIME: " + _str_lifetime,
			"BATTLE",
			"SCR_STATUS_APPLY_WEATHER"
		);
	}

	return _ref_status;
}