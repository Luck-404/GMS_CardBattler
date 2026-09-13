//===============================================================================//
//
// SCRIPT: SCR_STATUS_CHECK
// FUNCTION: Searches for a Status by ID/name.
//           Supports Global Statuses or Statuses attached to a battle Beast.
//
// ARGUMENTS: _str_id is the Status ID/name to find, and _ref_owner is either a
//            battle Beast or global.list_statuses.
// RETURNS: The matching Status instance, or -1 if no valid match is found.
//
//===============================================================================//

function scr_status_check(_str_id,_ref_owner){

	//====================//
	//GET STATUS LIST//
	//====================//
	var _list_statuses = undefined;

	if (_ref_owner == global.list_statuses){
		_list_statuses = global.list_statuses;
	}
	else{

		if (!instance_exists(_ref_owner)){
			return -1;
		}

		_list_statuses = _ref_owner._list_statuses;
	}

	//----------------------//
	//VALIDATE STATUS LIST//
	//----------------------//
	if (!ds_exists(_list_statuses,ds_type_list)){
		return -1;
	}

	//================//
	//SEARCH STATUS//
	//================//
	for (var _it_status = 0;_it_status < ds_list_size(_list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_name == _str_id){
			return _ref_status;
		}
	}

	return -1;
}