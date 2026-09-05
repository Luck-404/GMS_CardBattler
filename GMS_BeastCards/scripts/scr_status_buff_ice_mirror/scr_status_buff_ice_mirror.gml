//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ICE_MIRROR
// FUNCTION: Handles Ice Mirror.
//           Unstackable Timed Buff.
//           For 3 rounds, successful enemy Attack damage to the host
//           grants the host 2 Armor.
//
//===============================================================================//

function scr_status_buff_ice_mirror(
	_str_tag,
	_ref_status,
	_val_magnitude=undefined,
	_val_lifetime=undefined
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

			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime =
				max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status =
				scr_check_for_status(
					"ICE_MIRROR",
					_ref_target
				);

			//------------------//
			//REFRESH EXISTING//
			//------------------//
			if (_ref_existing_status != -1){

				_ref_existing_status._val_status_magnitude =
					_val_magnitude;

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

			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				true,
				false
			);

			_ref_new_status._scr_status =
				scr_status_buff_ice_mirror;

			_ref_new_status._ref_host =
				_ref_target;

			_ref_new_status._str_status_type =
				"BUFF";

			_ref_new_status._str_status_name =
				"ICE_MIRROR";

			_ref_new_status._str_status_desc =
				"WHEN STRUCK, GAIN 2 ARMOR";

			_ref_new_status._spr_status =
				spr_status_buff_ice_mirror;

			_ref_new_status._ct_status_stacks =
				1;

			_ref_new_status._flag_status_stackable =
				false;

			_ref_new_status._val_status_magnitude =
				_val_magnitude;

			_ref_new_status._str_trigger_region =
				"END";

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

			scr_status_tick_lifetime(
				_ref_status
			);

			scr_reposition_statuses(
				_ref_host
			);

		break;


		//-----//
		//DEATH//
		//-----//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_destroy_status(_ref_status);
			}

		break;
	}

	return undefined;
}