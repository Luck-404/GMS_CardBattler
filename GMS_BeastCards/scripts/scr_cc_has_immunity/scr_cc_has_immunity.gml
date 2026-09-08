//===============================================================================//
//
// SCRIPT: SCR_HAS_CC_IMMUNITY
// FUNCTION: Returns whether a living Beast currently has an active status
//           granting Crowd Control immunity.
//
//===============================================================================//

function scr_cc_has_immunity(_ref_beast){

	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	for (var _it_status = 0; _it_status < ds_list_size(_ref_beast._list_statuses); _it_status++){

		var _ref_status =
			ds_list_find_value(_ref_beast._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._flag_status_cc_immunity){
			return true;
		}
	}

	return false;
}