//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_WEATHER
// FUNCTION: Removes every active Weather Status.
//           Runs each Weather's normal DEATH cleanup before removal.
//
// ARGUMENTS: None.
// RETURNS: The number of Weather Statuses removed.
//
//===============================================================================//

function scr_status_clear_weather(){

	//----------------------//
	//VALIDATE GLOBAL LIST//
	//----------------------//
	if (!ds_exists(global.list_statuses,ds_type_list)){
		return 0;
	}

	var _ct_removed = 0;

	//===================//
	//REMOVE ALL WEATHER//
	//===================//
	for (var _it_status = ds_list_size(global.list_statuses) - 1;_it_status >= 0;_it_status--){

		var _ref_status = ds_list_find_value(global.list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "WEATHER"){
			continue;
		}

		//--------------------//
		//RUN WEATHER CLEANUP//
		//--------------------//
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