//===============================================================================//
//
// SCRIPT: SCR_STATUS_CLEANSE
// FUNCTION: Authoritative Beast-hosted Status cleanse entry point.
//           Filters eligible Statuses by type/category and optional Status ID.
//           Supports random-N, ALL, and OLDEST whole-Status cleansing.
//           Supports partial stack cleansing across every matching Status.
//           Respects uncleansable Statuses unless explicitly overridden.
//           Runs each Status's normal DEATH cleanup before full removal.
//           Rebuilds partially cleansed stackable Statuses through their APPLY
//           logic so Status-owned secondary effects remain synchronized.
//           Owns cleanse popup, VFX, repositioning, and result accounting.
//
// ARGUMENTS: _ref_target is the Beast being cleansed.
//            _var_filter is a Status type/category string or array of types.
//            _var_amount is a number, "ALL", or "OLDEST".
//            _stct_options optionally configures mode, exact Status ID,
//            uncleansable override, popup visibility, and forced VFX.
// RETURNS: Struct containing Statuses affected, Statuses removed, and stacks
//          removed.
//
//===============================================================================//

function scr_status_cleanse(_ref_target,_var_filter,_var_amount=1,_stct_options=undefined){

	//================//
	//DEFAULT RESULT//
	//================//
	var _stct_result = {
		_ct_statuses_affected: 0,
		_ct_statuses_removed: 0,
		_ct_stacks_removed: 0
	};

	#region VALIDATION

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return _stct_result;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return _stct_result;
	}

	#endregion

	#region OPTIONS

	//==============//
	//DEFAULT MODE//
	//==============//
	var _str_mode = "STATUS";
	var _str_status_id = undefined;

	var _flag_ignore_uncleansable = false;
	var _flag_show_popups = true;
	var _flag_force_vfx = false;

	//================//
	//READ OPTIONS//
	//================//
	if (is_struct(_stct_options)){

		if (variable_struct_exists(_stct_options,"_str_mode")){
			_str_mode = string_upper(_stct_options._str_mode);
		}

		if (variable_struct_exists(_stct_options,"_str_status_id")){
			_str_status_id = _stct_options._str_status_id;
		}

		if (variable_struct_exists(_stct_options,"_flag_ignore_uncleansable")){
			_flag_ignore_uncleansable = _stct_options._flag_ignore_uncleansable;
		}

		if (variable_struct_exists(_stct_options,"_flag_show_popups")){
			_flag_show_popups = _stct_options._flag_show_popups;
		}

		if (variable_struct_exists(_stct_options,"_flag_force_vfx")){
			_flag_force_vfx = _stct_options._flag_force_vfx;
		}
	}

	//----------------//
	//VALIDATE MODE//
	//----------------//
	if (
		_str_mode != "STATUS" &&
		_str_mode != "STACKS"
	){
		return _stct_result;
	}

	#endregion

	#region FILTER

	var _arr_status_types = [];

	//================//
	//ARRAY FILTER//
	//================//
	if (is_array(_var_filter)){

		for (
			var _it_filter = 0;
			_it_filter < array_length(_var_filter);
			_it_filter++
		){

			if (!is_string(_var_filter[_it_filter])){
				continue;
			}

			array_push(
				_arr_status_types,
				string_upper(_var_filter[_it_filter])
			);
		}
	}

	//================//
	//STRING FILTER//
	//================//
	else if (is_string(_var_filter)){

		switch (string_upper(_var_filter)){

			case "NEGATIVE":

				_arr_status_types = [
					"DEBUFF",
					"DOT",
					"CC"
				];

			break;

			case "POSITIVE":

				_arr_status_types = [
					"BUFF",
					"AURA"
				];

			break;

			case "ALL":

				_arr_status_types = [
					"AURA",
					"BUFF",
					"CC",
					"DEBUFF",
					"DOT"
				];

			break;

			case "AURA":
			case "BUFF":
			case "CC":
			case "DEBUFF":
			case "DOT":

				array_push(
					_arr_status_types,
					string_upper(_var_filter)
				);

			break;
		}
	}

	//----------------//
	//VALIDATE FILTER//
	//----------------//
	if (array_length(_arr_status_types) <= 0){
		return _stct_result;
	}

	#endregion

	#region SELECTION

	var _str_selection = "RANDOM";
	var _ct_amount = 1;

	//================//
	//STRING AMOUNT//
	//================//
	if (is_string(_var_amount)){

		switch (string_upper(_var_amount)){

			case "ALL":
				_str_selection = "ALL";
			break;

			case "OLDEST":
				_str_selection = "OLDEST";
				_ct_amount = 1;
			break;

			default:
				return _stct_result;
		}
	}

	//================//
	//NUMERIC AMOUNT//
	//================//
	else{

		_ct_amount = floor(_var_amount);

		if (_ct_amount <= 0){
			return _stct_result;
		}
	}

	//--------------------------//
	//STACK MODE SELECTION RULE//
	//--------------------------//
	if (
		_str_mode == "STACKS" &&
		_str_selection == "OLDEST"
	){
		return _stct_result;
	}

	#endregion

	#region CANDIDATES

	var _arr_candidates = [];

	//==================//
	//BUILD CANDIDATES//
	//==================//
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

		//================//
		//TYPE MATCH//
		//================//
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

		//================//
		//UNCLEANSABLE//
		//================//
		if (
			!_flag_ignore_uncleansable &&
			variable_instance_exists(
				_ref_status,
				"_flag_status_uncleansable"
			) &&
			_ref_status._flag_status_uncleansable
		){
			continue;
		}

		//==================//
		//EXACT STATUS ID//
		//==================//
		if (
			_str_status_id != undefined &&
			_ref_status._str_status_name != _str_status_id
		){
			continue;
		}

		array_push(
			_arr_candidates,
			_ref_status
		);
	}

	if (array_length(_arr_candidates) <= 0){

		if (_flag_force_vfx){
			scr_battle_vfx_cleanse(_ref_target);
		}

		return _stct_result;
	}

	#endregion

	#region STATUS MODE

	if (_str_mode == "STATUS"){

		var _arr_selected = [];

		//================//
		//SELECT ALL//
		//================//
		if (_str_selection == "ALL"){

			for (
				var _it_status = 0;
				_it_status < array_length(_arr_candidates);
				_it_status++
			){
				array_push(
					_arr_selected,
					_arr_candidates[_it_status]
				);
			}
		}

		//================//
		//SELECT OLDEST//
		//================//
		else if (_str_selection == "OLDEST"){

			array_push(
				_arr_selected,
				_arr_candidates[0]
			);
		}

		//================//
		//SELECT RANDOM N//
		//================//
		else{

			var _arr_pool = [];

			for (
				var _it_status = 0;
				_it_status < array_length(_arr_candidates);
				_it_status++
			){
				array_push(
					_arr_pool,
					_arr_candidates[_it_status]
				);
			}

			var _ct_select = min(
				_ct_amount,
				array_length(_arr_pool)
			);

			repeat (_ct_select){

				if (array_length(_arr_pool) <= 0){
					break;
				}

				var _it_selected = irandom(
					array_length(_arr_pool) - 1
				);

				array_push(
					_arr_selected,
					_arr_pool[_it_selected]
				);

				array_delete(
					_arr_pool,
					_it_selected,
					1
				);
			}
		}

		//================//
		//REMOVE STATUSES//
		//================//
		for (
			var _it_status = 0;
			_it_status < array_length(_arr_selected);
			_it_status++
		){

			var _ref_status =
				_arr_selected[_it_status];

			if (!instance_exists(_ref_status)){
				continue;
			}

			//================//
			//SNAPSHOT STATUS//
			//================//
			var _str_status_name =
				_ref_status._str_status_name;

			var _str_status_type =
				_ref_status._str_status_type;

			var _ct_stacks_before = 1;

			if (
				variable_instance_exists(
					_ref_status,
					"_ct_status_stacks"
				)
			){
				_ct_stacks_before = max(
					1,
					_ref_status._ct_status_stacks
				);
			}

			//================//
			//NORMAL CLEANUP//
			//================//
			if (_ref_status._scr_status != undefined){

				_ref_status._scr_status(
					"DEATH",
					_ref_status
				);
			}
			else{

				scr_status_destroy(
					_ref_status
				);
			}

			//================//
			//ACCOUNT RESULT//
			//================//
			_stct_result._ct_statuses_affected++;
			_stct_result._ct_statuses_removed++;
			_stct_result._ct_stacks_removed +=
				_ct_stacks_before;

			//================//
			//POPUP//
			//================//
			if (
				_flag_show_popups &&
				instance_exists(_ref_target)
			){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"CLEANSED " + _str_status_name,
					undefined,
					c_green,
					_ref_target.x + irandom_range(-32,32),
					_ref_target.y - 24 + irandom_range(-32,32)
				);
			}

			//================//
			//DEBUG CLEANSE//
			//================//
			if (instance_exists(_ref_target)){

				scr_debug_log_cleanse_result(
					_ref_target,
					_str_status_name,
					_str_status_type,
					_ct_stacks_before,
					_ct_stacks_before,
					0,
					"STATUS"
				);
			}
		}
	}

	#endregion

	#region STACK MODE

	else{

		//================//
		//REDUCE STATUSES//
		//================//
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

			//================//
			//SNAPSHOT STATUS//
			//================//
			var _ct_stacks_before = 1;

			if (
				variable_instance_exists(
					_ref_status,
					"_ct_status_stacks"
				)
			){
				_ct_stacks_before = max(
					1,
					_ref_status._ct_status_stacks
				);
			}

			var _ct_remove =
				(_str_selection == "ALL")
				? _ct_stacks_before
				: min(_ct_amount,_ct_stacks_before);

			if (_ct_remove <= 0){
				continue;
			}

			var _ct_stacks_remaining =
				_ct_stacks_before -
				_ct_remove;

			var _str_status_name =
				_ref_status._str_status_name;

			var _str_status_type =
				_ref_status._str_status_type;

			var _scr_status =
				_ref_status._scr_status;

			var _val_lifetime = undefined;
			var _val_lifetime_max = undefined;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_lifetime"
				)
			){
				_val_lifetime =
					_ref_status._val_status_lifetime;

				_val_lifetime_max =
					_val_lifetime;
			}

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_lifetime_max"
				)
			){
				_val_lifetime_max =
					_ref_status._val_status_lifetime_max;
			}

			//====================//
			//REMOVE ENTIRE STATUS//
			//====================//
			if (_ct_stacks_remaining <= 0){

				if (_scr_status != undefined){

					_scr_status(
						"DEATH",
						_ref_status
					);
				}
				else{

					scr_status_destroy(
						_ref_status
					);
				}

				_stct_result._ct_statuses_removed++;
			}

			//=====================//
			//REMOVE PARTIAL STACKS//
			//=====================//
			else{

				/*
					Preserve the existing rebuild behavior.

					Destroying and rebuilding lets Status-owned secondary
					effects such as Frostbite Maximum-HP loss, Venom stat
					penalties, and Weakness modifiers remain synchronized.
				*/

				if (_scr_status != undefined){

					_scr_status(
						"DEATH",
						_ref_status
					);

					if (instance_exists(_ref_host)){

						var _ref_rebuilt_status =
							undefined;

						var _flag_plague_dot = (
							_str_status_name == "BLEED" ||
							_str_status_name == "POISON" ||
							_str_status_name == "VENOM"
						);

						//========================//
						//REBUILD REMAINING STACKS//
						//========================//
						repeat (_ct_stacks_remaining){

							if (_flag_plague_dot){

								// Suppress recursive Plague Garden on rebuild.
								_ref_rebuilt_status = _scr_status(
									"APPLY",
									undefined,
									_val_lifetime_max,
									false,
									_ref_host
								);
							}
							else if (
								_str_status_name == "BURN" ||
								_str_status_name == "NATURES_BOND" ||
								_str_status_name == "OVERHEALTH" ||
								_str_status_name == "TOXIC_HIDE" ||
								_str_status_name == "BOOST" ||
								_str_status_name == "REGENERATION" ||
								_str_status_name == "CINDERGUARD" ||
								_str_status_name == "BATTLE_FRENZY" ||
								_str_status_name == "HEMOPHILIA" ||
								_str_status_name == "MOLTEN_BRAND" ||
								_str_status_name == "WHITEOUT"
							){

								_ref_rebuilt_status = _scr_status(
									"APPLY",
									undefined,
									_val_lifetime_max,
									undefined,
									_ref_host
								);
							}
							else{

								_ref_rebuilt_status = _scr_status(
									"APPLY",
									undefined,
									_val_lifetime_max,
									_ref_host
								);
							}
						}

						//=================//
						//PRESERVE DURATION//
						//=================//
						if (instance_exists(_ref_rebuilt_status)){

							if (
								_val_lifetime != undefined &&
								variable_instance_exists(
									_ref_rebuilt_status,
									"_val_status_lifetime"
								)
							){
								_ref_rebuilt_status._val_status_lifetime =
									_val_lifetime;
							}

							if (
								_val_lifetime_max != undefined &&
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
				}

				else{

					_ref_status._ct_status_stacks =
						_ct_stacks_remaining;
				}
			}

			//================//
			//ACCOUNT RESULT//
			//================//
			_stct_result._ct_statuses_affected++;
			_stct_result._ct_stacks_removed +=
				_ct_remove;

			//================//
			//POPUP//
			//================//
			if (
				_flag_show_popups &&
				instance_exists(_ref_host)
			){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_ct_remove) +
						" " + _str_status_name,
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
					_ct_stacks_before,
					_ct_remove,
					_ct_stacks_remaining,
					"STACKS"
				);
			}
		}
	}

	#endregion

	#region PRESENTATION

	if (instance_exists(_ref_target)){

		scr_status_reposition(
			_ref_target
		);

		if (
			_stct_result._ct_statuses_affected > 0 ||
			_flag_force_vfx
		){
			scr_battle_vfx_cleanse(
				_ref_target
			);
		}
	}

	#endregion

	return _stct_result;
}
