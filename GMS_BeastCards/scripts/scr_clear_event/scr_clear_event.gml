//===============================================================================//
//
// SCRIPT: SCR_CLEAR_EVENT
// FUNCTION: Removes all active EVENT statuses.
//           Runs each Event status's normal death and cleanup behavior.
//
//===============================================================================//

function scr_clear_event(){

	for (var _it_status = ds_list_size(global.list_statuses) - 1; _it_status >= 0; _it_status--){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "EVENT"){
			continue;
		}

		//--------------------//
		//RUN EVENT CLEANUP//
		//--------------------//
		if (_ref_status._scr_status != undefined){
			_ref_status._scr_status("DEATH",_ref_status);
		}
		else{
			scr_destroy_status(_ref_status);
		}
	}
}