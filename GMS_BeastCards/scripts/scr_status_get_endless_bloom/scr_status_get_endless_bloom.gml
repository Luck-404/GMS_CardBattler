//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_ENDLESS_BLOOM
// FUNCTION: Returns the active Endless Bloom Status when it protects the
//           supplied team.
//           Returns -1 when Endless Bloom is absent or belongs to another team.
//
//===============================================================================//

function scr_status_get_endless_bloom(_str_team){

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
	//GET ENDLESS BLOOM//
	//=====================//
	var _ref_status = scr_status_check("ENDLESS_BLOOM",global.list_statuses);

	if (_ref_status == -1){
		return -1;
	}

	if (!instance_exists(_ref_status)){
		return -1;
	}

	//----------------//
	//VALIDATE TEAM//
	//----------------//
	if (!variable_instance_exists(_ref_status,"_str_status_team")){
		return -1;
	}

	if (_ref_status._str_status_team != _str_team){
		return -1;
	}

	return _ref_status;
}