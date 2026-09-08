//===============================================================================//
//
// SCRIPT: scr_status_check_cerulean_weather
// FUNCTION: Returns true if any Cerulean Weather is currently active.
//           Recognizes Rain, Snow, and Storming.
//
//===============================================================================//

function scr_status_check_cerulean_weather(){

	if (
		scr_status_check(
			"WEATHER: RAIN",
			global.list_statuses
		) != -1
	){
		return true;
	}

	if (
		scr_status_check(
			"WEATHER: SNOW",
			global.list_statuses
		) != -1
	){
		return true;
	}

	if (
		scr_status_check(
			"WEATHER: STORMING",
			global.list_statuses
		) != -1
	){
		return true;
	}

	return false;
}