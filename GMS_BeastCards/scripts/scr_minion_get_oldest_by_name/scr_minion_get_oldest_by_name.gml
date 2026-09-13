//===============================================================================//
//
// SCRIPT: SCR_MINION_GET_OLDEST_BY_NAME
// FUNCTION: Returns the oldest hosted Minion matching a supplied Minion name.
//           Returns undefined when no matching Minion exists.
//
// INPUTS:   _ref_host        - Battle Beast hosting the Minions.
//           _str_minion_name - Minion name to search for.
//
//===============================================================================//

function scr_minion_get_oldest_by_name(_ref_host,_str_minion_name){

	//---------------//
	//VALIDATE HOST//
	//---------------//
	if (!instance_exists(_ref_host)){
		return undefined;
	}

	//--------------------//
	//VALIDATE MINION LIST//
	//--------------------//
	if (!ds_exists(_ref_host._list_minions,ds_type_list)){
		return undefined;
	}

	//------------------//
	//FIND OLDEST MATCH//
	//------------------//
	for (var _it_minion = 0;_it_minion < ds_list_size(_ref_host._list_minions);_it_minion++){

		var _ref_minion = ds_list_find_value(
			_ref_host._list_minions,
			_it_minion
		);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		if (_ref_minion._str_name == _str_minion_name){
			return _ref_minion;
		}
	}

	return undefined;
}