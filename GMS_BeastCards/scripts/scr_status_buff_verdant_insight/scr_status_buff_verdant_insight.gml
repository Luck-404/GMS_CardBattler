//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_VERDANT_INSIGHT
// FUNCTION: Handles Verdant Insight.
//           Unstackable Timed Buff.
//           Increases Magical Power and Magical Defense by stored Magnitude.
//           Reapplication refreshes duration without increasing stats again.
//           Removes its stat bonuses when the Buff expires.
//
//===============================================================================//

function scr_status_buff_verdant_insight(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!is_struct(_ref_target._ref_unit)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------//
			//DEFAULTS//
			//----------//
			if (_val_magnitude == undefined){
				_val_magnitude = 20;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,_val_magnitude);
			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("VERDANT_INSIGHT",_ref_target);

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
			_ref_new_status._scr_status = scr_status_buff_verdant_insight;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "VERDANT_INSIGHT";

			_ref_new_status._str_status_desc =
				"MPOW +" +
				string(_val_magnitude) +
				"; MDEF +" +
				string(_val_magnitude);

			_ref_new_status._spr_status = spr_status_buff_verdant_insight;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//=====================//
			//APPLY STAT BONUSES//
			//=====================//
			_ref_target._ref_unit._val_beast_mpow_stat += _val_magnitude;
			_ref_target._ref_unit._val_beast_mdef_stat += _val_magnitude;

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

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			//=====================//
			//REMOVE STAT BONUSES//
			//=====================//
			if (
				instance_exists(_ref_host) &&
				is_struct(_ref_host._ref_unit)
			){

				_ref_host._ref_unit._val_beast_mpow_stat =
					max(
						0,
						_ref_host._ref_unit._val_beast_mpow_stat -
							_ref_status._val_status_magnitude
					);

				_ref_host._ref_unit._val_beast_mdef_stat =
					max(
						0,
						_ref_host._ref_unit._val_beast_mdef_stat -
							_ref_status._val_status_magnitude
					);
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}