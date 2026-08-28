//===============================================================================//
//
// SCRIPT: SCR_APPLY_WEATHER_STATUS
// FUNCTION: x
//===============================================================================//
function scr_apply_weather_status(_str_event_name,_val_lifetime=undefined){

	var _ref_status = undefined;

	switch(_str_event_name){

		//--------//
		//SEEDFALL//
		//--------//
		case "SEEDFALL":

			_ref_status = scr_status_weather_seedfall("APPLY",undefined,_val_lifetime);

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
	}

	return _ref_status;
}