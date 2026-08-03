//===============================================================================//
//
// SCRIPT: SCR_GET_OLDEST_MINION_BY_NAME
// FUNCTION: Returns the oldest hosted minion matching a supplied minion name.
//           Returns undefined when no matching minion exists.
//
//===============================================================================//

function scr_get_oldest_minion_by_name(_ref_host,_str_minion_name){

	if (!instance_exists(_ref_host)){
		return undefined;
	}

	for (var _it_minion = 0; _it_minion < ds_list_size(_ref_host._list_minions); _it_minion++){

		var _ref_minion = ds_list_find_value(_ref_host._list_minions,_it_minion);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._str_name == _str_minion_name){
			return _ref_minion;
		}
	}

	return undefined;
}