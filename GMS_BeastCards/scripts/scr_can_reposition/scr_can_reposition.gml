//===============================================================================//
//
// SCRIPT: SCR_CAN_REPOSITION
// FUNCTION: Returns whether a living battle Beast may be repositioned.
//           Checks active status metadata for movement restrictions.
//
//===============================================================================//
function scr_can_reposition(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_beast._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_beast._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			variable_instance_exists(
				_ref_status,
				"_flag_status_prevent_reposition"
			) &&
			_ref_status._flag_status_prevent_reposition
		){
			return false;
		}
	}

	return true;
}