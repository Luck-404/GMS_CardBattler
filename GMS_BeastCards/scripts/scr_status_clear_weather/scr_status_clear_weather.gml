//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_WEATHER
// FUNCTION: Removes the single active Weather Status through its normal DEATH
//           cleanup path. Weather is owned by GLOBAL.REF_STATUS_WEATHER.
//
// ARGUMENTS: None.
// RETURNS: 1 when a Weather Status was removed; otherwise 0.
//
//===============================================================================//

function scr_status_clear_weather(){

	if (
		!variable_global_exists("ref_status_weather") ||
		!instance_exists(global.ref_status_weather)
	){
		global.ref_status_weather = undefined;
		return 0;
	}

	var _ref_status = global.ref_status_weather;

	if (
		variable_instance_exists(_ref_status,"_scr_status") &&
		is_callable(_ref_status._scr_status)
	){
		script_execute(
			_ref_status._scr_status,
			"DEATH",
			_ref_status
		);
	}
	else{
		scr_status_destroy(_ref_status);
	}

	if (instance_exists(_ref_status)){
		scr_status_destroy(_ref_status);
	}

	global.ref_status_weather = undefined;

	return 1;
}
