//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_EVENT
// FUNCTION: Removes every active Event Status.
//           Runs each Event's normal DEATH cleanup before removal.
//           Does not affect active Weather.
//
// ARGUMENTS: None.
// RETURNS: The number of Event Statuses removed.
//
//===============================================================================//

function scr_status_clear_event(){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return 0;
	}

	var _ct_removed = 0;

	//==================//
	//REMOVE ALL EVENTS//
	//==================//
	for (var _it_status = ds_list_size(global.list_statuses) - 1;_it_status >= 0;_it_status--){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "EVENT"){
			continue;
		}

		//------------------//
		//RUN EVENT CLEANUP//
		//------------------//
		if (_ref_status._scr_status != undefined){
			_ref_status._scr_status("DEATH",_ref_status);
		}
		else{
			scr_status_destroy(_ref_status);
		}

		_ct_removed++;
	}

	return _ct_removed;
}