//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_NEGATIVE_STACKS
// FUNCTION: Removes every cleansable negative status from a target Beast.
//           Negative statuses include DEBUFF, DOT, and CC.
//           Returns the total number of status stacks removed rather than
//           the number of status instances removed.
//           Runs each status's normal DEATH cleanup before removal.
//
//===============================================================================//

function scr_cleanse_negative_stacks(_ref_target){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	var _arr_cleanse = [];
	var _ct_stacks_removed = 0;

	//------------------------//
	//COLLECT NEGATIVE STATUSES//
	//------------------------//
	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_target._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_target._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		//----------------------//
		//CHECK NEGATIVE TYPE//
		//----------------------//
		var _flag_negative = (
			_ref_status._str_status_type == "DOT" ||
			_ref_status._str_status_type == "DEBUFF" ||
			_ref_status._str_status_type == "CC"
		);

		if (!_flag_negative){
			continue;
		}

		//-------------------//
		//CHECK UNCLEANSABLE//
		//-------------------//
		if (_ref_status._flag_status_uncleansable){
			continue;
		}

		array_push(
			_arr_cleanse,
			_ref_status
		);
	}

	//----------------//
	//CLEANSE STATUSES//
	//----------------//
	for (
		var _it_status = 0;
		_it_status < array_length(_arr_cleanse);
		_it_status++
	){

		var _ref_status =
			_arr_cleanse[_it_status];

		if (!instance_exists(_ref_status)){
			continue;
		}

		//----------------//
		//COUNT STACKS//
		//----------------//
		var _ct_status_stacks =
			1;

		if (
			variable_instance_exists(
				_ref_status,
				"_ct_status_stacks"
			)
		){

			_ct_status_stacks =
				max(
					1,
					_ref_status._ct_status_stacks
				);
		}

		_ct_stacks_removed +=
			_ct_status_stacks;

		var _str_status_name =
			_ref_status._str_status_name;

		//--------------------//
		//RUN NORMAL CLEANUP//
		//--------------------//
		if (_ref_status._scr_status != undefined){

			_ref_status._scr_status(
				"DEATH",
				_ref_status
			);
		}
		else{

			scr_destroy_status(
				_ref_status
			);
		}

		//----------//
		//FEEDBACK//
		//----------//
		scr_spawn_popup_scrolling(
			"TEXT",
			"CLEANSED " + _str_status_name,
			undefined,
			c_green,
			_ref_target.x + irandom_range(-32,32),
			_ref_target.y - 24 + irandom_range(-32,32)
		);
	}

	return _ct_stacks_removed;
}