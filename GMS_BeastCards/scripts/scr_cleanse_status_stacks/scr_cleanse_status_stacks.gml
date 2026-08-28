//===============================================================================//
//
// SCRIPT: SCR_CLEANSE_STATUS_STACKS
// FUNCTION: Removes a number of stacks from every cleansable status matching
//           one of the supplied status types.
//           Fully removes statuses reduced to zero stacks.
//           Rebuilds partially cleansed statuses through their own APPLY logic
//           so stack-based secondary effects remain synchronized.
//
//===============================================================================//
function scr_cleanse_status_stacks(_ref_target,_arr_status_types,_ct_amount){

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!is_array(_arr_status_types)){
		return 0;
	}

	if (_ct_amount <= 0){
		return 0;
	}

	var _arr_candidates = [];
	var _ct_stacks_removed = 0;

	//----------------//
	//BUILD CANDIDATES//
	//----------------//
	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_target._list_statuses);
		_it_status++
	){

		var _ref_status = ds_list_find_value(
			_ref_target._list_statuses,
			_it_status
		);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._flag_status_uncleansable){
			continue;
		}

		var _flag_type_match = false;

		for (
			var _it_type = 0;
			_it_type < array_length(_arr_status_types);
			_it_type++
		){

			if (
				_ref_status._str_status_type ==
				_arr_status_types[_it_type]
			){
				_flag_type_match = true;
				break;
			}
		}

		if (!_flag_type_match){
			continue;
		}

		array_push(_arr_candidates,_ref_status);
	}

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//----------------//
	//REDUCE STATUSES//
	//----------------//
	for (
		var _it_status = 0;
		_it_status < array_length(_arr_candidates);
		_it_status++
	){

		var _ref_status =
			_arr_candidates[_it_status];

		if (!instance_exists(_ref_status)){
			continue;
		}

		var _ref_host =
			_ref_status._ref_host;

		if (!instance_exists(_ref_host)){
			continue;
		}

		var _ct_stacks_before =
			max(1,_ref_status._ct_status_stacks);

		var _ct_remove =
			min(_ct_amount,_ct_stacks_before);

		var _ct_stacks_remaining =
			_ct_stacks_before -
			_ct_remove;

		var _str_status_name =
			_ref_status._str_status_name;

		var _scr_status =
			_ref_status._scr_status;

		var _val_lifetime =
			_ref_status._val_status_lifetime;

		var _val_lifetime_max =
			_val_lifetime;

		if (
			variable_instance_exists(
				_ref_status,
				"_val_status_lifetime_max"
			)
		){
			_val_lifetime_max =
				_ref_status._val_status_lifetime_max;
		}

		//----------------------//
		//REMOVE ENTIRE STATUS//
		//----------------------//
		if (_ct_stacks_remaining <= 0){

			if (_scr_status != undefined){
				_scr_status("DEATH",_ref_status);
			}
			else{
				scr_destroy_status(_ref_status);
			}
		}

		//------------------------//
		//REMOVE PARTIAL STACKS//
		//------------------------//
		else{

			/*
				Destroy and rebuild the status instead of directly
				changing its stack counter.

				This lets statuses such as Venom and Weakness undo
				their existing stack effects before the remaining
				stacks are reapplied.
			*/

			if (_scr_status != undefined){

				_scr_status("DEATH",_ref_status);

				global.ref_target_beast =
					_ref_host;

				var _ref_rebuilt_status =
					undefined;

				repeat (_ct_stacks_remaining){

					_ref_rebuilt_status =
						_scr_status(
							"APPLY",
							undefined,
							_val_lifetime_max
						);
				}

				//-------------------//
				//PRESERVE DURATION//
				//-------------------//
				if (instance_exists(_ref_rebuilt_status)){

					_ref_rebuilt_status._val_status_lifetime =
						_val_lifetime;

					if (
						variable_instance_exists(
							_ref_rebuilt_status,
							"_val_status_lifetime_max"
						)
					){
						_ref_rebuilt_status._val_status_lifetime_max =
							_val_lifetime_max;
					}
				}
			}
			else{
				_ref_status._ct_status_stacks =
					_ct_stacks_remaining;
			}
		}

		_ct_stacks_removed +=
			_ct_remove;

		//-------------//
		//CLEANSE TEXT//
		//-------------//
		scr_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_ct_remove) + " " + _str_status_name,
			undefined,
			c_green,
			_ref_host.x + irandom_range(-32,32),
			_ref_host.y - 24 + irandom_range(-32,32)
		);
	}

	//-----------------------//
	//RESTORE ORIGINAL TARGET//
	//-----------------------//
	if (instance_exists(_ref_original_target)){
		global.ref_target_beast = _ref_original_target;
	}
	else{
		global.ref_target_beast = _ref_target;
	}

	scr_reposition_statuses(_ref_target);

	return _ct_stacks_removed;
}