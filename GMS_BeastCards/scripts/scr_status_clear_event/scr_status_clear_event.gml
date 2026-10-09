//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_EVENT
// FUNCTION: Removes the single active Event Status through its normal DEATH
//           cleanup path. Event is owned by GLOBAL.REF_STATUS_EVENT.
//
// ARGUMENTS: None.
// RETURNS: 1 when an Event Status was removed; otherwise 0.
//
//===============================================================================//

function scr_status_clear_event(){

	if (
		!variable_global_exists("ref_status_event") ||
		!instance_exists(global.ref_status_event)
	){
		global.ref_status_event = undefined;
		return 0;
	}

	var _ref_status = global.ref_status_event;

	if (
		variable_instance_exists(_ref_status,"_scr_status") &&
		is_callable(_ref_status._scr_status)
	){
		script_execute(
			_ref_status._scr_status,
			"DEATH",
			_ref_status
		);
	}
	else{
		scr_status_destroy(_ref_status);
	}

	if (instance_exists(_ref_status)){
		scr_status_destroy(_ref_status);
	}

	global.ref_status_event = undefined;

	return 1;
}
