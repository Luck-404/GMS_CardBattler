//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_FROZEN
// FUNCTION: Handles the Frozen crowd-control status.
//           Unstackable Timed.
//           Prevents the host from acting or being repositioned.
//           Each time Frozen loses 1 round of duration, the host gains
//           1 Frostbite before Frozen's lifetime is decremented.
//
//===============================================================================//

function scr_status_cc_frozen(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
		//APPLY//
		//-------//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//DEFAULT LENGTH//
			//----------------//
			if (_val_lifetime == undefined){
				_val_lifetime = 1;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_check_for_status("FROZEN",_ref_target);

			//-----------------//
			//REFRESH EXISTING//
			//-----------------//
			if (_ref_existing_status != -1){

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

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

			_ref_new_status._scr_status = scr_status_cc_frozen;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "CC";
			_ref_new_status._str_status_name = "FROZEN";

			_ref_new_status._str_status_desc =
				"FROZEN; CANNOT ACT OR REPOSITION; GAINS 1 FROSTBITE EACH ROUND";

			_ref_new_status._spr_status = spr_status_cc_frozen;

			_ref_new_status._ct_status_stacks = 1;

			//-------------------//
			//PREVENT REPOSITION//
			//-------------------//
			_ref_new_status._flag_status_prevent_reposition = true;

			//------------------//
			//TRIGGER AT TURN END//
			//------------------//
			_ref_new_status._str_trigger_region = "END";

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

			//--------------------------------//
			//APPLY FROSTBITE BEFORE DURATION//
			//--------------------------------//
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

			scr_reposition_statuses(_ref_host);

		break;


		//-------//
		//DEATH//
		//-------//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}