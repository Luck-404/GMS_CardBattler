
//===============================================================================//
//
// SCRIPT: SCR_STATUS_GET_BLOODMIST
// FUNCTION: Returns the active Bloodmist Event Status.
// RETURNS: Status reference when active; otherwise -1.
//
//===============================================================================//

function scr_status_get_bloodmist(){

	//---------------------//
	//VALIDATE EVENT REF//
	//---------------------//
	if (!variable_global_exists("ref_status_event")){
		return -1;
	}

	//================//
	//CHECK BLOODMIST//
	//================//
	var _ref_bloodmist = scr_status_check("EVENT: BLOODMIST","EVENT");

	if (
		_ref_bloodmist == -1 ||
		!instance_exists(_ref_bloodmist)
	){
		return -1;
	}

	return _ref_bloodmist;
}
