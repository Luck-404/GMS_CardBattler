//===============================================================================//
//
// SCRIPT: SCR_GET_HEART_OF_FOREST_STATUS
// FUNCTION: Returns the active Heart of the Forest status protecting the
//           supplied team.
//           Returns -1 when no matching status exists.
//
//===============================================================================//

function scr_get_heart_of_forest_status(_str_team){

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
			"HEART_OF_THE_FOREST"
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