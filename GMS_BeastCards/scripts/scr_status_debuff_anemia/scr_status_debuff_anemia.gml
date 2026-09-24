
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_ANEMIA
// FUNCTION: Handles the Anemia Debuff.
//           Reduces the host's PHYPOW by up to 30.
//           Unstackable Timed Debuff lasting 3 rounds by default.
//           Reapplication refreshes lifetime without reducing PHYPOW again.
//           Restores the exact PHYPOW reduction when removed.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference or undefined.
//
//===============================================================================//

function scr_status_debuff_anemia(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!is_struct(_ref_target._ref_unit)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"ANEMIA",
				_ref_target
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//------------------//
				//REFRESH LIFETIME//
				//------------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"REDUCES PHYPOW BY " +
					string(_ref_existing_status._val_status_magnitude);

				return _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//===================//
			//INITIALIZE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//================//
			//STATUS DATA//
			//================//
			_ref_new_status._scr_status = scr_status_debuff_anemia;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "ANEMIA";

			//================//
			//STATUS SPRITE//
			//================//
			_ref_new_status._spr_status = spr_status_debuff_anemia;

			//================//
			//STATUS RULES//
			//================//
			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REDUCE PHYPOW//
			//================//
			var _val_ppow_before =
				_ref_target._ref_unit._val_beast_ppow_stat;

			_ref_target._ref_unit._val_beast_ppow_stat = max(
				0,
				_val_ppow_before - 30
			);

			//======================//
			//STORE ACTUAL REDUCTION//
			//======================//
			_ref_new_status._val_status_magnitude =
				_val_ppow_before -
				_ref_target._ref_unit._val_beast_ppow_stat;

			//================//
			//DESCRIPTION//
			//================//
			_ref_new_status._str_status_desc =
				"REDUCES PHYPOW BY " +
				string(_ref_new_status._val_status_magnitude);

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//================//
			//REPOSITION STATUS//
			//================//
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

			//================//
			//UPDATE LIFETIME//
			//================//
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

			//================//
			//RESTORE PHYPOW//
			//================//
			if (
				instance_exists(_ref_host) &&
				is_struct(_ref_host._ref_unit)
			){

				_ref_host._ref_unit._val_beast_ppow_stat +=
					_ref_status._val_status_magnitude;
			}

			//================//
			//DESTROY STATUS//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}