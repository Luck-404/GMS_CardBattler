//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_WHITEOUT
// FUNCTION: Handles Whiteout.
//           Reduces effective Accuracy for 3 rounds.
//           Reapplication refreshes duration.
//
//===============================================================================//

function scr_status_debuff_whiteout(
	_str_tag,
	_ref_status,
	_val_lifetime=undefined,
	_val_magnitude=undefined
){

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

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 50;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			_val_magnitude =
				clamp(
					_val_magnitude,
					0,
					100
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"WHITEOUT",
					_ref_target
				);

			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				_ref_existing_status._val_status_magnitude =
					_val_magnitude;

				_ref_existing_status._str_status_desc =
					"ACCURACY -" +
					string(_val_magnitude) +
					"%";

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

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			_ref_new_status._scr_status =
				scr_status_debuff_whiteout;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"WHITEOUT";

			_ref_new_status._str_status_desc =
				"ACCURACY -" +
				string(_val_magnitude) +
				"%";

			_ref_new_status._spr_status =
				spr_status_debuff_whiteout;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				"END";

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

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

				scr_status_destroy(_ref_status);

				return undefined;
			}

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}