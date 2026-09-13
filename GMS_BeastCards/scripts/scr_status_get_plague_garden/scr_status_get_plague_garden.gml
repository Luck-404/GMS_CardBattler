//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_PLAGUE_GARDEN
// FUNCTION: Returns the active Plague Garden Status owned by the supplied team.
//           Returns -1 when that team does not currently have Plague Garden.
//
//===============================================================================//

function scr_status_get_plague_garden(_str_team){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!variable_global_exists("list_statuses")){
		return -1;
	}

	if (!ds_exists(global.list_statuses,ds_type_list)){
		return -1;
	}

	//=====================//
	//FIND PLAGUE GARDEN//
	//=====================//
	for (var _it_status = 0;_it_status < ds_list_size(global.list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_name != "PLAGUE_GARDEN"){
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