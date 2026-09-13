//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_OLDEST_DOT
// FUNCTION: Cleanses the oldest cleansable DoT from a target Beast.
//           Removes the full Status including all stacks.
//
// ARGUMENTS: _ref_target is the Beast whose oldest cleansable DoT is removed.
// RETURNS: 1 when a DoT is successfully cleansed; otherwise 0.
//
//===============================================================================//

function scr_status_cleanse_oldest_dot(_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	//================//
	//FIND OLDEST DOT//
	//================//
	var _ref_dot = undefined;

	for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		//-------------------//
		//CHECK UNCLEANSABLE//
		//-------------------//
		if (
			variable_instance_exists(_ref_status,"_flag_status_uncleansable") &&
			_ref_status._flag_status_uncleansable
		){
			continue;
		}

		_ref_dot = _ref_status;

		break;
	}

	//--------------//
	//NO DOT FOUND//
	//--------------//
	if (!instance_exists(_ref_dot)){
		return 0;
	}

	var _str_status_name = _ref_dot._str_status_name;
	var _str_status_type = _ref_dot._str_status_type;

	var _ct_status_stacks = 1;

	if (variable_instance_exists(_ref_dot,"_ct_status_stacks")){
		_ct_status_stacks = max(1,_ref_dot._ct_status_stacks);
	}

	//================//
	//CLEANSE STATUS//
	//================//
	if (_ref_dot._scr_status != undefined){
		_ref_dot._scr_status("DEATH",_ref_dot);
	}
	else{
		scr_status_destroy(_ref_dot);
	}

	//======================//
	//CLEANSE PRESENTATION//
	//======================//
	if (instance_exists(_ref_target)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CLEANSED " + _str_status_name,
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		scr_battle_vfx_cleanse(_ref_target);
	}

	//================//
	//DEBUG CLEANSE//
	//================//
	scr_debug_log_cleanse_result(
		_ref_target,
		_str_status_name,
		_str_status_type,
		_ct_status_stacks,
		0,
		"SCR_STATUS_CLEANSE_OLDEST_DOT"
	);

	return 1;
}