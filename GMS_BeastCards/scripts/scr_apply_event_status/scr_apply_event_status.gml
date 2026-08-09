//===============================================================================//
//
// SCRIPT: SCR_APPLY_EVENT_STATUS
// FUNCTION: Applies a global Event or Weather status.
//           Accepts an optional lifetime override.
//           Spawns feedback popup text for successful applications.
//
//===============================================================================//
function scr_apply_event_status(_str_event_name,_val_lifetime=undefined){

	var _ref_status = undefined;

	switch(_str_event_name){

		//----------//
		//BLOOMTIDE//
		//----------//
		case "BLOOMTIDE":

			_ref_status = scr_status_event_bloomtide("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: BLOOMTIDE",
					undefined,
					c_green,
					room_width * 0.5,
					room_height * 0.5
				);
			}

		break;


		//-------------//
		//RAPID GROWTH//
		//-------------//
		case "RAPID GROWTH":

			_ref_status = scr_status_event_rapid_growth("APPLY",undefined,_val_lifetime);

			if (_ref_status != undefined){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WEATHER: RAPID GROWTH",
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