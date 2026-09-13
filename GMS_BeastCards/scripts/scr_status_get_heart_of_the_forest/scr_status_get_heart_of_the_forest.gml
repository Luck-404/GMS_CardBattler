//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_HEART_OF_THE_FOREST
// FUNCTION: Returns the active Heart of the Forest Status protecting the
//           supplied team.
//           Returns -1 when no matching Status exists.
//
//===============================================================================//

function scr_status_get_heart_of_the_forest(_str_team){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!variable_global_exists("list_statuses")){
		return -1;
	}

	if (!ds_exists(global.list_statuses,ds_type_list)){
		return -1;
	}

	//===================//
	//FIND ACTIVE HEART//
	//===================//
	for (var _it_status = 0;_it_status < ds_list_size(global.list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_name != "HEART_OF_THE_FOREST"){
			continue;
		}

		if (!variable_instance_exists(_ref_status,"_str_team")){
			continue;
		}

		if (_ref_status._str_team != _str_team){
			continue;
		}

		return _ref_status;
	}

	return -1;
}