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

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return false;
	}

	//================//
	//CHECK WEATHER//
	//================//
	if (scr_status_check("WEATHER: RAIN",global.list_statuses) != -1){
		return true;
	}

	if (scr_status_check("WEATHER: SNOW",global.list_statuses) != -1){
		return true;
	}

	if (scr_status_check("WEATHER: STORMING",global.list_statuses) != -1){
		return true;
	}

	return false;
}