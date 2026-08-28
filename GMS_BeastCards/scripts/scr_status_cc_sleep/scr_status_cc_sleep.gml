//===============================================================================//
//
// SCRIPT: SCR_STATUS_CC_SLEEP
// FUNCTION: Handles the Sleep crowd-control status.
//           Unstackable Timed.
//           Prevents the host from acting while active.
//           Reapplication extends duration without shortening existing Sleep.
//           Each lifetime tick has a 25% + CON-based chance to wake early.
//           Taking damage also immediately removes Sleep.
//
//===============================================================================//
function scr_status_cc_sleep(_str_tag,_ref_status,_val_lifetime=undefined){

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
					"SLEEP",
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
				scr_status_cc_sleep;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"CC";

			_ref_new_status._str_status_name =
				"SLEEP";

			_ref_new_status._str_status_desc =
				"ASLEEP; CANNOT ACT";

			_ref_new_status._spr_status =
				spr_status_cc_sleep;

			_ref_new_status._ct_status_stacks =
				1;

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
			//CALCULATE WAKE//
			//----------------//
			var _val_con_stat =
				_ref_host._ref_unit._val_beast_con_stat;

			var _val_con_mod =
				scr_get_beast_grade_modifier(
					_val_con_stat
				);

			var _val_wake_chance =
				clamp(
					25 +
					floor(
						5 *
						_val_con_mod
					),
					0,
					100
				);

			//----------//
			//WAKE ROLL//
			//----------//
			var _val_wake_roll =
				irandom_range(
					1,
					100
				);

			if (_val_wake_roll <= _val_wake_chance){

				scr_spawn_popup_scrolling(
					"TEXT",
					"WOKE UP",
					undefined,
					c_white,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				scr_destroy_status(
					_ref_status
				);

				return true;
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

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}