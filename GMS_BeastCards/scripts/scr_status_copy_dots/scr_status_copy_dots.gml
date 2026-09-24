//===============================================================================//
//
// SCRIPT: SCR_STATUS_COPY_DOTS
// FUNCTION: Copies every active DoT from one Beast onto another.
//           Copies each source DoT's current stack count through its normal
//           APPLY callback and preserves the source's current duration.
//           Existing destination DoTs retain the longer current/max duration.
//
// ARGUMENTS: _ref_source is the Beast supplying DoTs and _ref_target is the
//            Beast receiving copies of those DoT stacks.
// RETURNS: The total number of DoT stacks successfully copied.
//
//===============================================================================//

function scr_status_copy_dots(_ref_source,_ref_target){

	//-----------------//
	//VALIDATE BEASTS//
	//-----------------//
	if (!instance_exists(_ref_source)){
		return 0;
	}

	if (!instance_exists(_ref_target)){
		return 0;
	}

	if (_ref_source == _ref_target){
		return 0;
	}

	if (_ref_target._val_cur_hp <= 0){
		return 0;
	}

	if (!ds_exists(_ref_source._list_statuses,ds_type_list)){
		return 0;
	}

	if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
		return 0;
	}

	//=====================//
	//SNAPSHOT SOURCE DOTS//
	//=====================//
	var _arr_dots = [];

	for (var _it_status = 0;_it_status < ds_list_size(_ref_source._list_statuses);_it_status++){

		var _ref_status = ds_list_find_value(_ref_source._list_statuses,_it_status);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//---------------------//
		//SNAPSHOT DOT VALUES//
		//---------------------//
		var _ct_stacks = max(1,_ref_status._ct_status_stacks);
		var _val_lifetime_current = _ref_status._val_status_lifetime;
		var _val_lifetime_max = _val_lifetime_current;

		if (variable_instance_exists(_ref_status,"_val_status_lifetime_max")){
			_val_lifetime_max = _ref_status._val_status_lifetime_max;
		}

		array_push(
			_arr_dots,
			{
				_str_status_name: _ref_status._str_status_name,
				_scr_status: _ref_status._scr_status,
				_ct_status_stacks: _ct_stacks,
				_val_status_lifetime: _val_lifetime_current,
				_val_status_lifetime_max: _val_lifetime_max
			}
		);
	}

	if (array_length(_arr_dots) <= 0){
		return 0;
	}

	var _ct_total_copied = 0;

	//================//
	//COPY EACH DOT//
	//================//
	for (var _it_dot = 0;_it_dot < array_length(_arr_dots);_it_dot++){

		var _stct_dot = _arr_dots[_it_dot];

		//-------------------------------//
		//SNAPSHOT DESTINATION DURATION//
		//-------------------------------//
		var _ref_existing = scr_status_check(_stct_dot._str_status_name,_ref_target);

		var _val_existing_lifetime = 0;
		var _val_existing_lifetime_max = 0;

		if (
			_ref_existing != -1 &&
			instance_exists(_ref_existing)
		){

			_val_existing_lifetime = _ref_existing._val_status_lifetime;
			_val_existing_lifetime_max = _val_existing_lifetime;

			if (variable_instance_exists(_ref_existing,"_val_status_lifetime_max")){
				_val_existing_lifetime_max = _ref_existing._val_status_lifetime_max;
			}
		}
		else{
			_ref_existing = -1;
		}

		//==================//
		//COPY EVERY STACK//
		//==================//
		repeat (_stct_dot._ct_status_stacks){

			var _ref_applied_status = undefined;

			// Preserve each DoT constructor's original optional argument positions.
			if (
				_stct_dot._str_status_name == "BLEED" ||
				_stct_dot._str_status_name == "POISON" ||
				_stct_dot._str_status_name == "VENOM"
			){
				_ref_applied_status = _stct_dot._scr_status(
					"APPLY",
					undefined,
					_stct_dot._val_status_lifetime_max,
					true,
					_ref_target
				);
			}
			else if (_stct_dot._str_status_name == "BURN"){
				_ref_applied_status = _stct_dot._scr_status(
					"APPLY",
					undefined,
					_stct_dot._val_status_lifetime_max,
					false,
					_ref_target
				);
			}
			else{
				_ref_applied_status = _stct_dot._scr_status(
					"APPLY",
					undefined,
					_stct_dot._val_status_lifetime_max,
					_ref_target
				);
			}

			if (instance_exists(_ref_applied_status)){
				_ct_total_copied++;
			}
		}

		//================================//
		//PRESERVE CURRENT DOT DURATION//
		//================================//
		var _ref_copied_status = scr_status_check(_stct_dot._str_status_name,_ref_target);

		if (
			_ref_copied_status == -1 ||
			!instance_exists(_ref_copied_status)
		){
			continue;
		}

		//----------------------------//
		//TARGET DID NOT HAVE THIS DOT//
		//----------------------------//
		if (_ref_existing == -1){

			_ref_copied_status._val_status_lifetime = _stct_dot._val_status_lifetime;
			_ref_copied_status._val_status_lifetime_max = _stct_dot._val_status_lifetime_max;
		}

		//-----------------------------//
		//TARGET ALREADY HAD THIS DOT//
		//-----------------------------//
		else{

			_ref_copied_status._val_status_lifetime = max(
				_val_existing_lifetime,
				_stct_dot._val_status_lifetime
			);

			_ref_copied_status._val_status_lifetime_max = max(
				_val_existing_lifetime_max,
				_stct_dot._val_status_lifetime_max
			);
		}
	}


	if (instance_exists(_ref_target)){
		scr_status_reposition(_ref_target);
	}

	return _ct_total_copied;
}