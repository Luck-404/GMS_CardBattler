//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_FROZEN
// FUNCTION: Handles Frozen.
//           Unstackable Timed Crowd Control Status.
//           Prevents the host from acting or being repositioned.
//           Each time Frozen loses 1 round of duration, the host gains
//           1 Frostbite before Frozen's lifetime is decremented.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Frozen Status, and _val_lifetime optionally sets duration.
// RETURNS: The active Frozen Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_cc_frozen(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//---------------//
			//CC LIFETIME//
			//---------------//
			_val_lifetime = scr_cc_get_lifetime(
				_val_lifetime,
				1
			);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("FROZEN",_ref_target);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//-----------------------//
				//ENSURE PERSISTENT VFX//
				//-----------------------//
				if (!instance_exists(_ref_existing_status._ref_persistent_vfx)){

					_ref_existing_status._ref_persistent_vfx = scr_battle_vfx_persistent(
						_ref_target,
						spr_battle_vfx_frozen,
						0,
						20,
						1
					);
				}

				return _ref_existing_status;
			}

			//---------------//
			//CREATE STATUS//
			//---------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//---------------------//
			//INITIALIZE LIFETIME//
			//---------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//-------------//
			//STATUS DATA//
			//-------------//
			_ref_new_status._scr_status = scr_status_cc_frozen;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "CC";
			_ref_new_status._str_status_name = "FROZEN";
			_ref_new_status._str_status_desc = "FROZEN; CANNOT ACT OR REPOSITION; GAINS 1 FROSTBITE EACH ROUND";

			_ref_new_status._spr_status = spr_status_cc_frozen;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//-------------------//
			//PREVENT REPOSITION//
			//-------------------//
			_ref_new_status._flag_status_prevent_reposition = true;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_frozen,
				0,
				20,
				1
			);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//===============================//
			//APPLY FROSTBITE BEFORE TICK//
			//===============================//
			var _ref_original_target = global.ref_target_beast;

			global.ref_target_beast = _ref_host;

			scr_status_dot_frostbite(
				"APPLY",
				undefined
			);

			global.ref_target_beast = _ref_original_target;

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}