//===============================================================================//
//
// SCRIPT: SCR_GET_PLAGUE_GARDEN_STATUS
// FUNCTION: Returns the active Plague Garden status owned by the supplied team.
//           Returns -1 if that team does not currently have Plague Garden.
//
//===============================================================================//

function scr_get_plague_garden_status(_str_team){

	for (
		var _it_status = 0;
		_it_status < ds_list_size(global.list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				global.list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			_ref_status._str_status_name !=
			"PLAGUE_GARDEN"
		){
			continue;
		}

		if (
			!variable_instance_exists(
				_ref_status,
				"_str_status_team"
			)
		){
			continue;
		}

		if (
			_ref_status._str_status_team !=
			_str_team
		){
			continue;
		}

		return _ref_status;
	}

	return -1;
}