//===============================================================================//
//
// SCR_CHECK_FOR_STATUS
// FUNCTION: Searches a status list for a status by ID/name.
//           Supports global statuses or statuses attached to a battle beast.
//           Returns the matching status instance, or -1 if not found.
//
//===============================================================================//
function scr_check_for_status(_str_id,_ref_owner){

	var _list_statuses;

	if (_ref_owner == global.statuses){
		_list_statuses = global.statuses;
	}
	else{
		_list_statuses = _ref_owner._list_statuses;
	}

	for (var _it_status = 0; _it_status < ds_list_size(_list_statuses); _it_status++){

		var _ref_status = ds_list_find_value(_list_statuses,_it_status);

		if (instance_exists(_ref_status) && _ref_status._str_status_name == _str_id){
			return _ref_status;
		}
	}

	return -1;
}