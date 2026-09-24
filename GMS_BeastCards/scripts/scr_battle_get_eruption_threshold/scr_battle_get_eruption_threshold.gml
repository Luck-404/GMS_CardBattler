//===============================================================================//
//
// SCRIPT: SCR_BATTLE_GET_ERUPTION_THRESHOLD
// FUNCTION: Returns the effective ERUPTION threshold.
//           Inferno Eternal reduces thresholds by its magnitude.
//           Thresholds cannot fall below 1.
//
//===============================================================================//

function scr_battle_get_eruption_threshold(_ct_threshold){

	//================//
	//BASE THRESHOLD//
	//================//
	_ct_threshold = max(
		1,
		floor(_ct_threshold)
	);

	//================//
	//VALIDATE LIST//
	//================//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return _ct_threshold;
	}

	//================//
	//CHECK INFERNO//
	//================//
	var _ref_inferno = scr_status_check(
		"INFERNO_ETERNAL",
		global.list_statuses
	);

	if (
		_ref_inferno == -1 ||
		!instance_exists(_ref_inferno)
	){
		return _ct_threshold;
	}

	//================//
	//REDUCE THRESHOLD//
	//================//
	return max(
		1,
		_ct_threshold - _ref_inferno._val_status_magnitude
	);
}