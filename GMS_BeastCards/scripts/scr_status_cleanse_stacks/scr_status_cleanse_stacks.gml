//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE_STACKS
// FUNCTION: Removes a number of stacks from every cleansable Status matching
//           one of the supplied Status types.
//           Fully removes Statuses reduced to zero stacks.
//           Rebuilds partially cleansed Statuses through their own APPLY logic
//           so stack-based secondary effects remain synchronized.
//           Logs the actual number of stacks removed from each Status.
//
// ARGUMENTS: _ref_target is the Beast being cleansed, _arr_status_types contains
//            eligible Status types, and _ct_amount is removed from each match.
// RETURNS: The total number of Status stacks successfully removed.
//
//===============================================================================//

function scr_status_cleanse_stacks(_ref_target,_arr_status_types,_ct_amount){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	if (!is_array(_arr_status_types)){
		return 0;
	}

	_ct_amount = floor(_ct_amount);

	if (_ct_amount <= 0){
		return 0;
	}

	var _arr_candidates = [];
	var _ct_stacks_removed = 0;

	//==================//
	//BUILD CANDIDATES//
	//==================//
	for (var _it_status = 0;_it_status < ds_list_size(_ref_target._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_target._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
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

		//------------------//
		//CHECK STATUS TYPE//
		//------------------//
		var _flag_type_match = false;

		for (var _it_type = 0;_it_type < array_length(_arr_status_types);_it_type++){

			if (_ref_status._str_status_type == _arr_status_types[_it_type]){
				_flag_type_match = true;
				break;
			}
		}

		if (!_flag_type_match){
			continue;
		}

		array_push(_arr_candidates,_ref_status);
	}

	//=======================//
	//STORE ORIGINAL TARGET//
	//=======================//
	var _ref_original_target = global.ref_target_beast;

	//==================//
	//REDUCE STATUSES//
	//==================//
	for (var _it_status = 0;_it_status < array_length(_arr_candidates);_it_status++){

		var _ref_status = _arr_candidates[_it_status];

		if (!instance_exists(_ref_status)){
			continue;
		}

		var _ref_host = _ref_status._ref_host;

		if (!instance_exists(_ref_host)){
			continue;
		}

		//----------------//
		//SNAPSHOT STATUS//
		//----------------//
		var _ct_stacks_before = max(1,_ref_status._ct_status_stacks);
		var _ct_remove = min(_ct_amount,_ct_stacks_before);
		var _ct_stacks_remaining = _ct_stacks_before - _ct_remove;

		var _str_status_name = _ref_status._str_status_name;
		var _str_status_type = _ref_status._str_status_type;

		var _scr_status = _ref_status._scr_status;

		var _val_lifetime = _ref_status._val_status_lifetime;
		var _val_lifetime_max = _val_lifetime;

		if (variable_instance_exists(_ref_status,"_val_status_lifetime_max")){
			_val_lifetime_max = _ref_status._val_status_lifetime_max;
		}

		//====================//
		//REMOVE ENTIRE STATUS//
		//====================//
		if (_ct_stacks_remaining <= 0){

			if (_scr_status != undefined){
				_scr_status("DEATH",_ref_status);
			}
			else{
				scr_status_destroy(_ref_status);
			}
		}

		//=====================//
		//REMOVE PARTIAL STACKS//
		//=====================//
		else{

			/*
				Destroy and rebuild the Status instead of directly changing
				its stack counter.

				This allows stack-based secondary effects such as Venom stat
				reductions, Weakness damage reduction, and Frostbite Maximum
				HP reduction to remain synchronized.
			*/

			if (_scr_status != undefined){

				_scr_status("DEATH",_ref_status);

				if (instance_exists(_ref_host)){

					global.ref_target_beast = _ref_host;

					var _ref_rebuilt_status = undefined;

					var _flag_plague_dot = (
						_str_status_name == "BLEED" ||
						_str_status_name == "POISON" ||
						_str_status_name == "VENOM"
					);

					//-----------------------//
					//REBUILD REMAINING STACKS//
					//-----------------------//
					repeat (_ct_stacks_remaining){

						if (_flag_plague_dot){

							_ref_rebuilt_status = _scr_status(
								"APPLY",
								undefined,
								_val_lifetime_max,
								false
							);
						}
						else{

							_ref_rebuilt_status = _scr_status(
								"APPLY",
								undefined,
								_val_lifetime_max
							);
						}
					}

					//-----------------//
					//PRESERVE DURATION//
					//-----------------//
					if (instance_exists(_ref_rebuilt_status)){

						_ref_rebuilt_status._val_status_lifetime = _val_lifetime;

						if (variable_instance_exists(_ref_rebuilt_status,"_val_status_lifetime_max")){
							_ref_rebuilt_status._val_status_lifetime_max = _val_lifetime_max;
						}
					}
				}
			}
			else{
				_ref_status._ct_status_stacks = _ct_stacks_remaining;
			}
		}

		_ct_stacks_removed += _ct_remove;

		//===============//
		//CLEANSE TEXT//
		//===============//
		if (instance_exists(_ref_host)){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"-" + string(_ct_remove) + " " + _str_status_name,
				undefined,
				c_green,
				_ref_host.x + irandom_range(-32,32),
				_ref_host.y - 24 + irandom_range(-32,32)
			);
		}

		//================//
		//DEBUG CLEANSE//
		//================//
		if (instance_exists(_ref_host)){

			scr_debug_log_cleanse_result(
				_ref_host,
				_str_status_name,
				_str_status_type,
				_ct_remove,
				_ct_stacks_remaining,
				"SCR_STATUS_CLEANSE_STACKS"
			);
		}
	}

	//========================//
	//RESTORE ORIGINAL TARGET//
	//========================//
	global.ref_target_beast = _ref_original_target;

	//======================//
	//CLEANSE PRESENTATION//
	//======================//
	if (instance_exists(_ref_target)){

		scr_status_reposition(_ref_target);

		if (_ct_stacks_removed > 0){
			scr_battle_vfx_cleanse(_ref_target);
		}
	}

	return _ct_stacks_removed;
}