//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_CRIPPLING_VINES
// FUNCTION: Handles the Crippling Vines Debuff.
//           Unstackable Timed.
//           Reduces the host's Physical Power by one major stage.
//           Prevents the host from being repositioned while active.
//           Reapplication refreshes duration without reducing Power again.
//
//===============================================================================//
function scr_status_debuff_crippling_vines(_str_tag,_ref_status,_val_lifetime=undefined){

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

			if (_ref_target._ref_unit == undefined){
				return undefined;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime =
				max(
					1,
					_val_lifetime
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"CRIPPLING_VINES",
					_ref_target
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//-----------------------//
			//CALCULATE PPOW REDUCTION//
			//-----------------------//
			var _val_ppow_before =
				_ref_target._ref_unit._val_beast_ppow_stat;

			_ref_target._ref_unit._val_beast_ppow_stat =
				max(
					0,
					_ref_target._ref_unit._val_beast_ppow_stat -
					20
				);

			var _val_ppow_reduction =
				_val_ppow_before -
				_ref_target._ref_unit._val_beast_ppow_stat;

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

			_ref_new_status._scr_status =
				scr_status_debuff_crippling_vines;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"CRIPPLING_VINES";

			_ref_new_status._str_status_desc =
				"PPOW -20; CANNOT REPOSITION";

			_ref_new_status._spr_status =
				spr_status_debuff_crippling_vines;

			_ref_new_status._ct_status_stacks =
				1;

			// Stores the exact PPOW actually removed.
			_ref_new_status._val_status_magnitude =
				_val_ppow_reduction;

			_ref_new_status._flag_status_prevent_reposition =
				true;

			_ref_new_status._str_trigger_region =
				"END";

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//----------------//
			//REGISTER STATUS//
			//----------------//
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

				scr_destroy_status(
					_ref_status
				);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				_ref_host
			);

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

			//----------------//
			//RESTORE PPOW//
			//----------------//
			if (
				instance_exists(_ref_host) &&
				_ref_host._ref_unit != undefined
			){

				_ref_host._ref_unit._val_beast_ppow_stat +=
					_ref_status._val_status_magnitude;
			}

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(
				_ref_status
			);

		break;
	}

	return undefined;
}