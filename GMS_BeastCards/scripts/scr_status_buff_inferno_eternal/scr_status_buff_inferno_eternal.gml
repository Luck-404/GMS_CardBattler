
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_INFERNO_ETERNAL
// FUNCTION: Global Buff that reduces all ERUPTION thresholds.
//           Unstackable and timed.
//           Reapplication refreshes duration and retains the higher magnitude.
//           All ERUPTION thresholds have a minimum of 1.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude=2, _val_lifetime=5.
//            _ref_target is retained for APPLY caller compatibility.
// RETURNS: Command-specific Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_inferno_eternal(_str_tag,_ref_status,_val_magnitude=2,_val_lifetime=5,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//===============//
			//VALIDATE LIST//
			//===============//
			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			_val_magnitude = max(0,floor(_val_magnitude));
			_val_lifetime = max(1,floor(_val_lifetime));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing = scr_status_check(
				"INFERNO_ETERNAL",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (
				_ref_existing != -1 &&
				instance_exists(_ref_existing)
			){

				//==========================//
				//RETAIN STRONGER MAGNITUDE//
				//==========================//
				_ref_existing._val_status_magnitude = max(
					_ref_existing._val_status_magnitude,
					_val_magnitude
				);

				//==================//
				//UPDATE DESCRIPTION//
				//==================//
				_ref_existing._str_status_desc =
					"ALL ERUPTION THRESHOLDS -" +
					string(_ref_existing._val_status_magnitude) +
					". MINIMUM THRESHOLD: 1.";

				//==================//
				//REFRESH LIFETIME//
				//==================//
				scr_status_refresh_lifetime(
					_ref_existing,
					_val_lifetime
				);

				scr_status_reposition(global.list_statuses);

				return _ref_existing;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//================//
			//INIT LIFETIME//
			//================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_inferno_eternal;

			_ref_new_status._ref_host = undefined;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "INFERNO_ETERNAL";

			_ref_new_status._str_status_desc =
				"ALL ERUPTION THRESHOLDS -" +
				string(_val_magnitude) +
				". MINIMUM THRESHOLD: 1.";

			_ref_new_status._spr_status = spr_status_buff_inferno_eternal;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			if (ds_exists(global.list_statuses,ds_type_list)){
				scr_status_reposition(global.list_statuses);
			}

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