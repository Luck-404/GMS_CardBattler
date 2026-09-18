//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_DISCHARGE_THRESHOLD
// FUNCTION: Returns the current Stormstruck threshold required for DISCHARGE.
//           Base threshold is 8.
//           Statuses may modify the threshold through
//           _ct_discharge_threshold_modifier.
//
// ARGUMENTS: _ref_host is the Beast being checked.
// RETURNS: Current DISCHARGE threshold.
//
//===============================================================================//

function scr_status_get_discharge_threshold(_ref_host){

	//================//
	//BASE THRESHOLD//
	//================//
	var _ct_threshold = 8;

	//----------------//
	//VALIDATE HOST//
	//----------------//
	if (!instance_exists(_ref_host)){
		return _ct_threshold;
	}

	if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
		return _ct_threshold;
	}

	//=====================//
	//STATUS MODIFICATIONS//
	//=====================//
	for (var _it_status = 0;_it_status < ds_list_size(_ref_host._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_host._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (!variable_instance_exists(_ref_status,"_ct_discharge_threshold_modifier")){
			continue;
		}

		_ct_threshold += _ref_status._ct_discharge_threshold_modifier;
	}

	//================//
	//FINAL THRESHOLD//
	//================//
	return max(4,floor(_ct_threshold));
}