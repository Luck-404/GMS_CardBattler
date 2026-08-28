//===============================================================================//
//
// SCRIPT: SCR_COPY_DOT_STATUSES
// FUNCTION: Copies every active DoT from one Beast onto another.
//           Copies the source's current stack count.
//           Uses each DoT's normal APPLY callback so stack-dependent side
//           effects resolve correctly.
//           Preserves current DoT duration rather than refreshing copied
//           statuses to full duration.
//           Returns the total number of DoT stacks copied.
//
//===============================================================================//

function scr_copy_dot_statuses(_ref_source,_ref_target){

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

	//====================//
	//SNAPSHOT SOURCE DOTS//
	//====================//
	var _arr_dots = [];

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_ref_source._list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_ref_source._list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (_ref_status._str_status_type != "DOT"){
			continue;
		}

		if (_ref_status._scr_status == undefined){
			continue;
		}

		//----------------//
		//GET STACK COUNT//
		//----------------//
		var _ct_stacks =
			max(
				1,
				_ref_status._ct_status_stacks
			);

		//------------------//
		//GET CURRENT LIFE//
		//------------------//
		var _val_lifetime_current =
			_ref_status._val_status_lifetime;

		//----------------//
		//GET MAXIMUM LIFE//
		//----------------//
		var _val_lifetime_max =
			_ref_status._val_status_lifetime;

		if (
			variable_instance_exists(
				_ref_status,
				"_val_status_lifetime_max"
			)
		){

			_val_lifetime_max =
				_ref_status._val_status_lifetime_max;
		}

		//----------------//
		//STORE SNAPSHOT//
		//----------------//
		array_push(
			_arr_dots,
			{
				_str_status_name :
					_ref_status._str_status_name,

				_scr_status :
					_ref_status._scr_status,

				_ct_status_stacks :
					_ct_stacks,

				_val_status_lifetime :
					_val_lifetime_current,

				_val_status_lifetime_max :
					_val_lifetime_max
			}
		);
	}

	if (array_length(_arr_dots) <= 0){
		return 0;
	}


	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	global.ref_target_beast =
		_ref_target;

	var _ct_total_copied =
		0;


	//================//
	//COPY EACH DOT//
	//================//
	for (
		var _it_dot = 0;
		_it_dot < array_length(_arr_dots);
		_it_dot++
	){

		var _stct_dot =
			_arr_dots[_it_dot];


		//================================//
		//SNAPSHOT DESTINATION DURATION//
		//================================//
		var _ref_existing =
			scr_check_for_status(
				_stct_dot._str_status_name,
				_ref_target
			);

		var _val_existing_lifetime =
			0;

		var _val_existing_lifetime_max =
			0;

		if (_ref_existing != -1){

			_val_existing_lifetime =
				_ref_existing._val_status_lifetime;

			if (
				variable_instance_exists(
					_ref_existing,
					"_val_status_lifetime_max"
				)
			){

				_val_existing_lifetime_max =
					_ref_existing._val_status_lifetime_max;
			}
			else{

				_val_existing_lifetime_max =
					_ref_existing._val_status_lifetime;
			}
		}


		//==================//
		//COPY EVERY STACK//
		//==================//
		repeat (_stct_dot._ct_status_stacks){

			script_execute(
				_stct_dot._scr_status,
				"APPLY",
				undefined,
				_stct_dot._val_status_lifetime_max
			);

			_ct_total_copied++;
		}


		//================================//
		//PRESERVE CURRENT DOT DURATION//
		//================================//
		var _ref_copied_status =
			scr_check_for_status(
				_stct_dot._str_status_name,
				_ref_target
			);

		if (_ref_copied_status != -1){

			//-----------------------------//
			//TARGET DID NOT HAVE THIS DOT//
			//-----------------------------//
			if (_ref_existing == -1){

				_ref_copied_status._val_status_lifetime =
					_stct_dot._val_status_lifetime;

				_ref_copied_status._val_status_lifetime_max =
					_stct_dot._val_status_lifetime_max;
			}

			//--------------------------------//
			//TARGET ALREADY HAD THIS DOT//
			//--------------------------------//
			else{

				_ref_copied_status._val_status_lifetime =
					max(
						_val_existing_lifetime,
						_stct_dot._val_status_lifetime
					);

				_ref_copied_status._val_status_lifetime_max =
					max(
						_val_existing_lifetime_max,
						_stct_dot._val_status_lifetime_max
					);
			}
		}
	}


	//----------------//
	//RESTORE TARGET//
	//----------------//
	if (instance_exists(_ref_original_target)){

		global.ref_target_beast =
			_ref_original_target;
	}
	else{

		global.ref_target_beast =
			_ref_target;
	}

	scr_reposition_statuses(
		_ref_target
	);

	return _ct_total_copied;
}