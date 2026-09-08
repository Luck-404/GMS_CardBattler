//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_STUN
// FUNCTION: Handles the Stun crowd-control status.
//           Unstackable Timed.
//           Prevents the host from acting while active.
//           Reapplication extends duration without shortening an existing Stun.
//
//===============================================================================//
function scr_status_cc_stun(_str_tag,_ref_status,_val_lifetime=undefined){

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

			//----------------//
			//CC LIFETIME//
			//----------------//
			_val_lifetime =
				scr_get_cc_lifetime(
					_val_lifetime,
					1
				);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_status_check(
					"STUN",
					_ref_target
				);

			//-----------------//
			//REFRESH EXISTING//
			//-----------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//------------------------//
				//ENSURE PERSISTENT VFX//
				//------------------------//
				if (
					!instance_exists(
						_ref_existing_status
							._ref_persistent_vfx
					)
				){

					_ref_existing_status
						._ref_persistent_vfx =
						scr_battle_vfx_persistent(
							_ref_target,
							spr_battle_vfx_stunned,
							0,
							-110,
							1
						);
				}

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

			_ref_new_status._scr_status =
				scr_status_cc_stun;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_name =
				"STUN";

			_ref_new_status._str_status_desc =
				"STUNNED, CANNOT ACT";

			_ref_new_status._spr_status =
				spr_status_cc_stun;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._str_trigger_region =
				"END";

			_ref_new_status._str_status_type =
				"CC";

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

			scr_status_reposition(
				_ref_target
			);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx =
				scr_battle_vfx_persistent(
					_ref_target,
					spr_battle_vfx_stunned,
					0,
					-110,
					1
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

				scr_status_destroy(
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

			scr_status_reposition(
				_ref_host
			);

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