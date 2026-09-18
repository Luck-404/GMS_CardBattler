//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_BLOODMIST
// FUNCTION: Returns the active Bloodmist Event Status.
// RETURNS: Status reference when active; otherwise -1.
//
//===============================================================================//

function scr_status_get_bloodmist(){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!variable_global_exists("list_statuses")){
		return -1;
	}

	if (!ds_exists(global.list_statuses,ds_type_list)){
		return -1;
	}

	//================//
	//CHECK BLOODMIST//
	//================//
	var _ref_bloodmist = scr_status_check("EVENT: BLOODMIST",global.list_statuses);

	if (
		_ref_bloodmist == -1 ||
		!instance_exists(_ref_bloodmist)
	){
		return -1;
	}

	return _ref_bloodmist;
}