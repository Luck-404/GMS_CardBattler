//===============================================================================//
//
// SCRIPT: SCR_CHECK_CERULEAN_WEATHER
// FUNCTION: Returns true if any Cerulean Weather is currently active.
//           Recognizes Rain, Snow, and Storming.
//
//===============================================================================//

function scr_check_cerulean_weather(){

	if (
		scr_check_for_status(
			"WEATHER: RAIN",
			global.list_statuses
		) != -1
	){
		return true;
	}

	if (
		scr_check_for_status(
			"WEATHER: SNOW",
			global.list_statuses
		) != -1
	){
		return true;
	}

	if (
		scr_check_for_status(
			"WEATHER: STORMING",
			global.list_statuses
		) != -1
	){
		return true;
	}

	return false;
}