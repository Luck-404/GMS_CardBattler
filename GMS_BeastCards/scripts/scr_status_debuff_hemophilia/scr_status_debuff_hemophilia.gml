
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DEBUFF_HEMOPHILIA
// FUNCTION: Handles Hemophilia.
//           Unstackable Timed Debuff lasting 3 rounds by default.
//           Whenever the host is struck by an enemy Attack, applies Bleed.
//           Reapplication refreshes lifetime without replacing magnitude.
//
// ARGUMENTS: _str_tag selects APPLY/TRIGGER/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_lifetime=undefined, _val_magnitude=undefined.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Status reference, trigger result, or undefined.
//
//===============================================================================//

function scr_status_debuff_hemophilia(_str_tag,_ref_status,_val_lifetime=undefined,_val_magnitude=undefined,_ref_target=undefined){

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

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 1;
			}

			_val_lifetime = max(1,floor(_val_lifetime));
			_val_magnitude = max(1,floor(_val_magnitude));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"HEMOPHILIA",
				_ref_target
			);

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				//-----------------------------//
				//PRESERVE ORIGINAL MAGNITUDE//
				//-----------------------------//
				// Do not overwrite _val_status_magnitude.

				//----------------//
				//REFRESH LIFETIME//
				//----------------//
				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"WHEN ATTACKED: GAIN " +
					string(_ref_existing_status._val_status_magnitude) +
					" BLEED";

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
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

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_debuff_hemophilia;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "DEBUFF";
			_ref_new_status._str_status_name = "HEMOPHILIA";

			_ref_new_status._str_status_desc =
				"WHEN ATTACKED: GAIN " +
				string(_val_magnitude) +
				" BLEED";

			_ref_new_status._spr_status = spr_status_debuff_hemophilia;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "END";

			//----------------------//
			//PREVENT TRIGGER REENTRY//
			//----------------------//
			_ref_new_status._flag_hemophilia_triggering = false;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//-----------------//
			//VALIDATE STATUS//
			//-----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (_ref_host._val_cur_hp <= 0){
				return false;
			}

			if (_ref_status._val_status_lifetime <= 0){
				return false;
			}

			//------------------//
			//PREVENT REENTRY//
			//------------------//
			if (_ref_status._flag_hemophilia_triggering){
				return false;
			}

			_ref_status._flag_hemophilia_triggering = true;

			//================//
			//TRIGGER FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"HEMOPHILIA",
				undefined,
				c_maroon,
				_ref_host.x,
				_ref_host.y - 48
			);

			//================//
			//APPLY BLEED//
			//================//
			var _flag_applied = false;

			var _ct_bleed = max(
				1,
				floor(_ref_status._val_status_magnitude)
			);

			repeat (_ct_bleed){

				if (!instance_exists(_ref_host)){
					break;
				}

				if (_ref_host._val_cur_hp <= 0){
					break;
				}

				if (instance_exists(scr_status_apply_dot("BLEED",_ref_host))){
					_flag_applied = true;
				}
			}

			//------------------//
			//CLEAR REENTRY FLAG//
			//------------------//
			if (instance_exists(_ref_status)){
				_ref_status._flag_hemophilia_triggering = false;
			}

			return _flag_applied;

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

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}