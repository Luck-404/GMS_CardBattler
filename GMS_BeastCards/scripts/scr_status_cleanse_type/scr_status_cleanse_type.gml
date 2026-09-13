//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_TYPE
// FUNCTION: Removes Statuses of a supplied type from a target Beast.
//           Randomly selects cleansable Statuses until the requested amount is
//           satisfied. Each cleanse removes the entire Status and all stacks.
//           Logs every successfully removed Status.
//
// ARGUMENTS: _ref_target is the Beast being cleansed, _str_status_type selects
//            the Status type, _ct_amount is the maximum number removed, and
//            _str_status_id optionally restricts cleansing to one Status ID.
// RETURNS: The number of Statuses successfully removed.
//
//===============================================================================//

function scr_status_cleanse_type(_ref_target,_str_status_type,_ct_amount,_str_status_id=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	_ct_amount = floor(_ct_amount);

	if (_ct_amount <= 0){
		return 0;
	}

	var _ct_removed = 0;

	//================//
	//REMOVE STATUSES//
	//================//
	while (_ct_removed < _ct_amount){

		var _arr_candidates = [];

		//------------------//
		//BUILD CANDIDATES//
		//------------------//
		for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

			var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			//-----------------//
			//CHECK STATUS TYPE//
			//-----------------//
			if (_ref_status._str_status_type != _str_status_type){
				continue;
			}

			//--------------------//
			//CHECK UNCLEANSABLE//
			//--------------------//
			if (
				variable_instance_exists(_ref_status,"_flag_status_uncleansable") &&
				_ref_status._flag_status_uncleansable
			){
				continue;
			}

			//----------------------//
			//CHECK SPECIFIC STATUS//
			//----------------------//
			if (
				_str_status_id != undefined &&
				_ref_status._str_status_name != _str_status_id
			){
				continue;
			}

			array_push(_arr_candidates,_ref_status);
		}

		//-----------------//
		//NO VALID STATUS//
		//-----------------//
		if (array_length(_arr_candidates) <= 0){
			break;
		}

		//================//
		//SELECT STATUS//
		//================//
		var _ref_status_cleanse = _arr_candidates[irandom(array_length(_arr_candidates) - 1)];

		if (!instance_exists(_ref_status_cleanse)){
			continue;
		}

		//----------------//
		//SNAPSHOT STATUS//
		//----------------//
		var _str_status_name = _ref_status_cleanse._str_status_name;
		var _str_cleanse_type = _ref_status_cleanse._str_status_type;

		var _ct_status_stacks = 1;

		if (variable_instance_exists(_ref_status_cleanse,"_ct_status_stacks")){
			_ct_status_stacks = max(1,_ref_status_cleanse._ct_status_stacks);
		}

		//================//
		//CLEANSE STATUS//
		//================//
		if (_ref_status_cleanse._scr_status != undefined){
			_ref_status_cleanse._scr_status("DEATH",_ref_status_cleanse);
		}
		else{
			scr_status_destroy(_ref_status_cleanse);
		}

		_ct_removed++;

		//==========//
		//FEEDBACK//
		//==========//
		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"CLEANSED " + _str_status_name,
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);

		//================//
		//DEBUG CLEANSE//
		//================//
		scr_debug_log_cleanse_result(
			_ref_target,
			_str_status_name,
			_str_cleanse_type,
			_ct_status_stacks,
			0,
			"SCR_STATUS_CLEANSE_TYPE"
		);
	}

	//======================//
	//CLEANSE PRESENTATION//
	//======================//
	if (_ct_removed > 0){
		scr_battle_vfx_cleanse(_ref_target);
	}

	return _ct_removed;
}