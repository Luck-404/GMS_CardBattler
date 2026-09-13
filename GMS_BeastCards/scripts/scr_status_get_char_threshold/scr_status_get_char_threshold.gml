//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_CHAR_THRESHOLD
// FUNCTION: Returns the current Burn threshold required to create Char.
//           Base threshold is 5 Burn.
//           Active Heatwave Weather reduces the threshold by 1.
//           Never allows the threshold to fall below 1.
//
// RETURNS: Current Char conversion threshold.
//
//===============================================================================//

function scr_status_get_char_threshold(){

	//================//
	//BASE THRESHOLD//
	//================//
	var _ct_threshold = 5;

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!variable_global_exists("list_statuses")){
		return _ct_threshold;
	}

	if (!ds_exists(global.list_statuses,ds_type_list)){
		return _ct_threshold;
	}

	//================//
	//HEATWAVE//
	//================//
	var _ref_heatwave = scr_status_check("WEATHER: HEATWAVE",global.list_statuses);

	if (_ref_heatwave != -1 && instance_exists(_ref_heatwave)){
		_ct_threshold--;
	}

	//================//
	//FINAL THRESHOLD//
	//================//
	return max(1,_ct_threshold);
}