//===============================================================================//
//
// SCRIPT: SCR_APPLY_WEATHER_STATUS
// FUNCTION: Applies or refreshes a global Weather status.
//           Reapplying the same Weather refreshes its lifetime.
//           Applying a different Weather removes all current Weather first.
//
//           ACTIVE WEATHER:
//           - SEEDFALL
//           - RAIN
//           - SNOW
//           - STORMING
//
//           PLANNED / COMMENTED OUT:
//           - HEATWAVE
//           - FIRESTORM
//
//===============================================================================//

function scr_apply_weather_status(_str_event_name,_val_lifetime=undefined){

	var _ref_status = undefined;

	//----------------------//
	//GET REQUESTED WEATHER//
	//----------------------//
	var _str_requested_weather =
		"WEATHER: " + _str_event_name;


	//----------------------//
	//CHECK CURRENT WEATHER//
	//----------------------//
	var _flag_same_weather_active = false;

	for (
		var _it_status = 0;
		_it_status < ds_list_size(global.list_statuses);
		_it_status++
	){

		var _ref_check_status =
			ds_list_find_value(
				global.list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_check_status)){
			continue;
		}

		if (_ref_check_status._str_status_type != "WEATHER"){
			continue;
		}

		if (
			_ref_check_status._str_status_name ==
			_str_requested_weather
		){

			_flag_same_weather_active = true;

			break;
		}
	}


	//---------------------------//
	//REPLACE DIFFERENT WEATHER//
	//---------------------------//
	if (!_flag_same_weather_active){

		scr_clear_weather();
	}


	//----------------//
	//APPLY WEATHER//
	//----------------//
	switch(_str_event_name){


		//----------//
		//SEEDFALL//
		//----------//
		case "SEEDFALL":

			_ref_status =
				scr_status_weather_seedfall(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: SEEDFALL",
					undefined,
					c_black,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//------//
		//RAIN//
		//------//
		case "RAIN":

			_ref_status =
				scr_status_weather_rain(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: RAIN",
					undefined,
					c_aqua,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//------//
		//SNOW//
		//------//
		case "SNOW":

			_ref_status =
				scr_status_weather_snow(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: SNOW",
					undefined,
					c_aqua,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//----------//
		//STORMING//
		//----------//
		case "STORMING":

			_ref_status =
				scr_status_weather_storming(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: STORMING",
					undefined,
					c_aqua,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		/*
		//----------//
		//HEATWAVE//
		//----------//
		case "HEATWAVE":

			_ref_status =
				scr_status_weather_heatwave(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: HEATWAVE",
					undefined,
					c_red,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//-----------//
		//FIRESTORM//
		//-----------//
		case "FIRESTORM":

			_ref_status =
				scr_status_weather_firestorm(
					"APPLY",
					undefined,
					_val_lifetime
				);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: FIRESTORM",
					undefined,
					c_red,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;
		*/
	}


	return _ref_status;
}