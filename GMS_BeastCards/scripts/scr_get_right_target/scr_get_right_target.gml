//===============================================================================//
//
// SCRIPT: SCR_GET_RIGHT_TARGET
// FUNCTION: Returns the living Beast immediately after the supplied target
//           in its team's alive formation list.
//           Returns undefined when no right target exists.
//
//===============================================================================//

function scr_get_right_target(_ref_target){

	//--------------------//
	//GET TARGET TEAM LIST//
	//--------------------//
	var _list_targets = scr_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return undefined;
	}

	//----------------//
	//GET TARGET INDEX//
	//----------------//
	var _it_target = ds_list_find_index(
		_list_targets,
		_ref_target
	);

	if (_it_target == -1){
		return undefined;
	}

	//------------------//
	//CHECK RIGHT INDEX//
	//------------------//
	var _it_right_target = _it_target + 1;
	var _ct_targets = ds_list_size(_list_targets);

	if (_it_right_target >= _ct_targets){
		return undefined;
	}

	//----------------//
	//GET RIGHT TARGET//
	//----------------//
	var _ref_right_target = ds_list_find_value(
		_list_targets,
		_it_right_target
	);

	if (!instance_exists(_ref_right_target)){
		return undefined;
	}

	return _ref_right_target;
}