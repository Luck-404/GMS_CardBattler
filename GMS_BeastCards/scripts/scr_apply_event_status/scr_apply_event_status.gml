//===============================================================================//
//
// SCR_APPLY_EVENT_STATUS
// FUNCTION: Applies a global event or weather status.
//           Triggers any associated effects and notification popups.
//
//===============================================================================//
function scr_apply_event_status(_str_event_name){

	switch(_str_event_name){
	
		case "BLOOMTIDE":

			scr_status_event_bloomtide(
				"APPLY",
				undefined
			);

			scr_spawn_popup_scrolling(
				"TEXT",
				"WEATHER: BLOOMTIDE",
				undefined,
				c_green,
				room_width * 0.5,
				room_height * 0.5
			);

		break;

		case "RAPID GROWTH":

			scr_status_event_rapid_growth("APPLY",undefined);

			scr_spawn_popup_scrolling(
				"TEXT",
				"WEATHER: RAPID GROWTH",
				undefined,
				c_black,
				room_width * 0.5,
				room_height * 0.5
			);

		break;
	}
}