//===============================================================================//
//
// SCR_DESTROY_STATUS
// FUNCTION: Removes a status from its owning list.
//           Supports global statuses and host-bound statuses.
//           Destroys the status instance and refreshes status icon positions.
//
//===============================================================================//
function scr_destroy_status(_ref_status){

	if (!instance_exists(_ref_status)){
		exit;
	}

	if (_ref_status._ref_host == undefined){

		var _ref_found_status = scr_check_for_status(_ref_status._str_status_name,global.list_statuses);

		if (_ref_found_status != -1){

			var _it_status = ds_list_find_index(global.list_statuses,_ref_found_status);

			if (_it_status != -1){
				ds_list_delete(global.list_statuses,_it_status);
			}

			instance_destroy(_ref_found_status);

			scr_reposition_statuses(global.list_statuses);
		}

		exit;
	}

	var _ref_host = _ref_status._ref_host;

	if (instance_exists(_ref_host)){

		var _ref_found_status = scr_check_for_status(_ref_status._str_status_name,_ref_host);

		if (_ref_found_status != -1){

			var _it_status = ds_list_find_index(_ref_host._list_statuses,_ref_found_status);

			if (_it_status != -1){
				ds_list_delete(_ref_host._list_statuses,_it_status);
			}

			instance_destroy(_ref_found_status);

			scr_reposition_statuses(_ref_host);
		}
	}
	else{
		instance_destroy(_ref_status);
	}
}