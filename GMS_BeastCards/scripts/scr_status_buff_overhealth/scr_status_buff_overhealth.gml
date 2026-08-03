//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_OVERHEALTH
// FUNCTION: Handles temporary Overhealth.
//           Grants a supplied amount of Overhealth for a supplied duration.
//           Reapplications add Overhealth and refresh duration.
//           Removes remaining status-granted Overhealth when expired.
//
//===============================================================================//

function scr_status_buff_overhealth(_str_tag,_ref_status,_val_magnitude,_val_lifetime){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target =
				global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 0;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"OVERHEALTH",
					_ref_target
				);

			//----------------//
			//STACK EXISTING//
			//----------------//
			if (_ref_existing_status != -1){

				_ref_target._val_overhealth +=
					_val_magnitude;

				_ref_existing_status._val_status_remaining +=
					_val_magnitude;

				_ref_existing_status._val_status_magnitude +=
					_val_magnitude;

				_ref_existing_status._ct_status_stacks++;

				_ref_existing_status._val_status_lifetime =
					_val_lifetime;

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status =
				instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

			_ref_new_status._val_status_lifetime =
				_val_lifetime;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._val_status_remaining =
				_val_magnitude;

			_ref_new_status._scr_status =
				scr_status_buff_overhealth;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"OVERHEALTH";

			_ref_new_status._str_status_desc =
				"TEMPORARY OVERHEALTH";

			_ref_new_status._spr_status =
				spr_status_buff_overhealth;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"START";

			//----------------//
			//GRANT OVERHEALTH//
			//----------------//
			_ref_target._val_overhealth +=
				_val_magnitude;

			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_reposition_statuses(
				_ref_target
			);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(_ref_status);

				return undefined;
			}

			//----------------------------//
			//TRACK REMAINING OVERHEALTH//
			//----------------------------//
			_ref_status._val_status_remaining =
				min(
					_ref_status._val_status_remaining,
					_ref_host._val_overhealth
				);

			//----------------//
			//REDUCE LIFETIME//
			//----------------//
			_ref_status._val_status_lifetime--;

			if (_ref_status._val_status_lifetime <= 0){
				_ref_status._str_status_command = "DEATH";
			}
			else{
				_ref_status._str_status_command = "WAIT";
			}

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host =
				_ref_status._ref_host;

			if (instance_exists(_ref_host)){

				_ref_host._val_overhealth =
					max(
						0,
						_ref_host._val_overhealth -
						_ref_status._val_status_remaining
					);
			}

			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}