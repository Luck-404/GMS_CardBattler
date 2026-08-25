//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_DRAINED
// FUNCTION: Handles the Drained Debuff.
//           Unstackable Timed.
//           Reduces Magical Power and Magical Defense by 20.
//           Reapplication refreshes duration without reducing stats again.
//           Restores the exact removed stat amounts when the Debuff ends.
//
//===============================================================================//
function scr_status_debuff_drained(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

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

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("DRAINED",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

				return _ref_existing_status;
			}

			//-----------------------//
			//REDUCE MAGICAL POWER//
			//-----------------------//
			var _val_mpow_before =
				_ref_target._ref_unit._val_beast_mpow_stat;

			_ref_target._ref_unit._val_beast_mpow_stat =
				max(
					0,
					_ref_target._ref_unit._val_beast_mpow_stat -
					20
				);

			var _val_mpow_reduction =
				_val_mpow_before -
				_ref_target._ref_unit._val_beast_mpow_stat;

			//-------------------------//
			//REDUCE MAGICAL DEFENSE//
			//-------------------------//
			var _val_mdef_before =
				_ref_target._ref_unit._val_beast_mdef_stat;

			_ref_target._ref_unit._val_beast_mdef_stat =
				max(
					0,
					_ref_target._ref_unit._val_beast_mdef_stat -
					20
				);

			var _val_mdef_reduction =
				_val_mdef_before -
				_ref_target._ref_unit._val_beast_mdef_stat;

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			_ref_new_status._scr_status =
				scr_status_debuff_drained;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"DEBUFF";

			_ref_new_status._str_status_name =
				"DRAINED";

			_ref_new_status._str_status_desc =
				"MPOW -20; MDEF -20";

			_ref_new_status._spr_status =
				spr_status_debuff_drained;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._val_status_magnitude =
				20;

			// Stores the exact amounts actually removed.
			_ref_new_status._val_drained_mpow_reduction =
				_val_mpow_reduction;

			_ref_new_status._val_drained_mdef_reduction =
				_val_mdef_reduction;

			_ref_new_status._str_trigger_region =
				"END";

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(_ref_new_status,_val_lifetime,false,false);

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_reposition_statuses(_ref_target);

			return _ref_new_status;

		break;


		//--------//
		//REPEAT//
		//--------//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_destroy_status(_ref_status);

				return undefined;
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (
				instance_exists(_ref_host) &&
				_ref_host._ref_unit != undefined
			){

				//----------------------//
				//RESTORE MAGICAL POWER//
				//----------------------//
				_ref_host._ref_unit._val_beast_mpow_stat +=
					_ref_status._val_drained_mpow_reduction;

				//------------------------//
				//RESTORE MAGICAL DEFENSE//
				//------------------------//
				_ref_host._ref_unit._val_beast_mdef_stat +=
					_ref_status._val_drained_mdef_reduction;
			}

			//---------------//
			//DESTROY STATUS//
			//---------------//
			scr_destroy_status(_ref_status);

		break;
	}

	return undefined;
}