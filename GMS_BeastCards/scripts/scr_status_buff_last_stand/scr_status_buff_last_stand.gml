//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_LAST_STAND
// FUNCTION: Handles Last Stand.
//           Unstackable Timed Buff.
//           Prevents the host's next fatal damage while active.
//           Leaves the host at 5 HP, removes all other nonpermanent Statuses,
//           grants Rage, and consumes itself.
//
// ARGUMENTS: _str_tag selects APPLY, REPEAT, TRIGGER, or DEATH.
//            _ref_status references an existing Last Stand Status.
//            _val_magnitude is the Rage granted when triggered.
//            _val_lifetime optionally sets the duration.
// RETURNS: Status reference on APPLY, true/false on TRIGGER.
//
//===============================================================================//

function scr_status_buff_last_stand(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			_val_magnitude = max(0,floor(_val_magnitude));
			_val_lifetime = max(1,_val_lifetime);

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("LAST_STAND",_ref_target);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				scr_status_refresh_lifetime(_ref_existing_status,_val_lifetime);

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

			//=====================//
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_last_stand;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "LAST_STAND";
			_ref_new_status._str_status_desc = "NEXT FATAL DAMAGE LEAVES HOST AT 5 HP; CLEANSE NONPERMANENT STATUSES; GAIN 2 RAGE";

			_ref_new_status._spr_status = spr_status_buff_last_stand;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_permanent = false;

			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = "END";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

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

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			var _ct_rage_gain = max(0,floor(_ref_status._val_status_magnitude));

			//================//
			//RESTORE TO 5 HP//
			//================//
			_ref_host._val_cur_hp = min(5,_ref_host._val_max_hp);

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"LAST STAND",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			//==================//
			//CONSUME LAST STAND//
			//==================//
			scr_status_buff_last_stand("DEATH",_ref_status);

			//=========================//
			//CLEAR TEMPORARY STATUSES//
			//=========================//
			scr_status_clear_nonpermanent(_ref_host);

			//================//
			//GAIN 2 RAGE//
			//================//
			if (_ct_rage_gain > 0){
				scr_status_gain_rage(_ref_host,_ct_rage_gain);
			}

			//================//
			//DEBUG TRIGGER//
			//================//
			scr_debug_log_battle_trigger(
				"LAST STAND",
				_ref_host,
				_ref_host,
				"HP SET TO " +
				string(_ref_host._val_cur_hp) +
				" | RAGE +" +
				string(_ct_rage_gain),
				"SCR_STATUS_BUFF_LAST_STAND"
			);

			return true;

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