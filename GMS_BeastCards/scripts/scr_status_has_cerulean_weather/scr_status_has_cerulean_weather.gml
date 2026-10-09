
//===============================================================================//
//
// SCRIPT: SCR_STATUS_HAS_CERULEAN_WEATHER
// FUNCTION: Checks whether any Cerulean Weather is currently active.
//           Recognizes Rain, Snow, and Storming.
//
// ARGUMENTS: None.
// RETURNS: True when any Cerulean Weather is active; otherwise false.
//
//===============================================================================//

function scr_status_has_cerulean_weather(){

	//================//
	//CHECK WEATHER//
	//================//
	if (scr_status_check("WEATHER: RAIN","WEATHER") != -1){
		return true;
	}

	if (scr_status_check("WEATHER: SNOW","WEATHER") != -1){
		return true;
	}

	if (scr_status_check("WEATHER: STORMING","WEATHER") != -1){
		return true;
	}

	return false;
}
