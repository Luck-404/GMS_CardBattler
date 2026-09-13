//===============================================================================//
//
// SCRIPT: SCR_CC_HAS_IMMUNITY
// FUNCTION: Returns whether a living Beast currently has an active Status
//           granting Crowd Control immunity.
//
//===============================================================================//

function scr_cc_has_immunity(_ref_beast){

	//----------------//
	//VALIDATE BEAST//
	//----------------//
	if (!instance_exists(_ref_beast)){
		return false;
	}

	if (
		_ref_beast._str_list != "ALIVE" ||
		_ref_beast._val_cur_hp <= 0
	){
		return false;
	}

	if (!ds_exists(_ref_beast._list_statuses,ds_type_list)){
		return false;
	}

	//===================//
	//CHECK CC IMMUNITY//
	//===================//
	for (var _it_status = 0;_it_status < ds_list_size(_ref_beast._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_beast._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (!variable_instance_exists(_ref_status,"_flag_status_cc_immunity")){
			continue;
		}

		if (_ref_status._flag_status_cc_immunity){
			return true;
		}
	}

	return false;
}