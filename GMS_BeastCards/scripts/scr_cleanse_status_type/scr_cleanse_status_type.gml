//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_STATUS_TYPE
// FUNCTION: Removes statuses of a supplied type from a target Beast.
//           Randomly selects cleansable statuses until amount is satisfied.
//           Cleansing a status removes the entire status and all of its stacks.
//
//===============================================================================//

function scr_cleanse_status_type(_ref_target,_str_status_type,_ct_amount,_str_status_id=undefined){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ct_amount <= 0){
		return 0;
	}

	var _ct_removed = 0;

	//----------------//
	//REMOVE STATUSES//
	//----------------//
	while (_ct_removed < _ct_amount){

		var _arr_candidates = [];

		//----------------//
		//BUILD CANDIDATES//
		//----------------//
		for (var _it_status = 0; _it_status < ds_list_size(_ref_target._list_statuses); _it_status++){

			var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

			if (!instance_exists(_ref_status)){
				continue;
			}

			if (_ref_status._str_status_type != _str_status_type){
				continue;
			}

			if (_ref_status._flag_status_uncleansable){
				continue;
			}

			//------------------------//
			//FUTURE SPECIFIC STATUS//
			//------------------------//
			/*
			if (_str_status_id != undefined){

				if (_ref_status._str_status_name != _str_status_id){
					continue;
				}
			}
			*/

			array_push(_arr_candidates,_ref_status);
		}

		//----------------//
		//NO VALID STATUS//
		//----------------//
		if (array_length(_arr_candidates) <= 0){
			break;
		}

		//----------------//
		//SELECT RANDOM//
		//----------------//
		var _ref_status_cleanse = _arr_candidates[irandom(array_length(_arr_candidates) - 1)];

		if (!instance_exists(_ref_status_cleanse)){
			continue;
		}

		var _str_status_name = _ref_status_cleanse._str_status_name;

		//----------------//
		//CLEANSE STATUS//
		//----------------//
		if (_ref_status_cleanse._scr_status != undefined){
			_ref_status_cleanse._scr_status("DEATH",_ref_status_cleanse);
		}
		else{
			scr_destroy_status(_ref_status_cleanse);
		}

		_ct_removed++;

		//-------------//
		//SPAWN POPUP//
		//-------------//
		scr_spawn_popup_scrolling(
			"TEXT",
			"CLEANSED " + _str_status_name,
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	return _ct_removed;
}