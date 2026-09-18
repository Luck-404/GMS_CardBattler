//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEAR_NONPERMANENT
// FUNCTION: Removes every nonpermanent Status from one Beast.
//           Permanent Statuses survive regardless of whether they are
//           cleansable or uncleansable.
//           Each removed Status resolves its normal DEATH cleanup.
//
// ARGUMENTS: _ref_target is the Beast whose temporary Statuses are removed.
// RETURNS: Number of Statuses removed.
//
//===============================================================================//

function scr_status_clear_nonpermanent(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	var _arr_remove = [];

	//===================//
	//BUILD REMOVE QUEUE//
	//===================//
	for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		var _flag_permanent = false;

		if (variable_instance_exists(_ref_status,"_flag_status_permanent")){
			_flag_permanent = _ref_status._flag_status_permanent;
		}

		if (_flag_permanent){
			continue;
		}

		array_push(_arr_remove,_ref_status);
	}

	//================//
	//REMOVE STATUSES//
	//================//
	var _ct_removed = 0;

	for (var _it_remove = 0;_it_remove < array_length(_arr_remove);_it_remove++){

		var _ref_status = _arr_remove[_it_remove];

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._scr_status != undefined){
			_ref_status._scr_status("DEATH",_ref_status);
		}
		else{
			scr_status_destroy(_ref_status);
		}

		_ct_removed++;
	}

	//================//
	//CLEANSE VFX//
	//================//
	if (_ct_removed > 0 && instance_exists(_ref_target)){
		scr_battle_vfx_cleanse(_ref_target);
	}

	return _ct_removed;
}