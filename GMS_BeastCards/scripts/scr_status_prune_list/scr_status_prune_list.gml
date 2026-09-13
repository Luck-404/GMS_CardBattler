//===============================================================================//
//
// SCRIPT: SCR_STATUS_PRUNE_LIST
// FUNCTION: Removes invalid Status instance references from a Status DS list.
//           Prevents destroyed Statuses from occupying invisible list slots.
//
// ARGUMENTS: _list_statuses is the Status DS list to sanitize.
// RETURNS: The number of invalid references removed.
//
//===============================================================================//

function scr_status_prune_list(_list_statuses){

	//----------------//
	//VALIDATE LIST//
	//----------------//
	if (!ds_exists(_list_statuses,ds_type_list)){
		return 0;
	}

	var _ct_removed = 0;

	//========================//
	//REMOVE INVALID STATUSES//
	//========================//
	for (var _it_status = ds_list_size(_list_statuses) - 1;_it_status >= 0;_it_status--){

		var _ref_status = ds_list_find_value(
			_list_statuses,
			_it_status
		);

		if (instance_exists(_ref_status)){
			continue;
		}

		ds_list_delete(
			_list_statuses,
			_it_status
		);

		_ct_removed++;
	}

	return _ct_removed;
}